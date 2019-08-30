defmodule GotchaWeb.GraphQL.Plugs.TokenAuthTest do
  use GotchaWeb.ConnCase, async: true

  alias Joken.CurrentTime.Mock

  alias GotchaWeb.GraphQL.Token
  alias GotchaWeb.GraphQL.Plugs.TokenAuth

  import Gotcha.Factory

  setup do
    {:ok, _pid} = start_supervised(Mock)
    [conn: build_conn()]
  end

  describe "get_current_player/2" do
    test "sets the current player to nil if there is no token", %{conn: conn} do
      conn = TokenAuth.get_current_player(conn)
      assert conn.assigns.current_player == nil
    end

    test "sets the current player to nil if token is expired", %{conn: conn} do
      player = insert(:player)

      token = generate_expired_token(player)

      conn =
        conn
        |> put_req_header("authorization", "Bearer #{token}")
        |> TokenAuth.get_current_player()

      assert conn.assigns.current_player == nil
    end

    test "sets the current player if token is valid", %{conn: conn} do
      player = insert(:player)
      token = TokenAuth.generate_signed_jwt(player)

      conn =
        conn
        |> put_req_header("authorization", "Bearer #{token}")
        |> TokenAuth.get_current_player()

      assert conn.assigns.current_player.id == player.id
      refute conn.halted
    end
  end

  defp generate_expired_token(player) do
    Mock.freeze()

    past = 1_499_951_920

    {:ok, token, _claims} =
      Token.generate_and_sign(%{
        "exp" => past + 1,
        "iat" => past,
        "nbf" => past - 1,
        "sub" => player.id
      })

    token
  end
end
