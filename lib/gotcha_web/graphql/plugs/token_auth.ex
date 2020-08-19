defmodule GotchaWeb.GraphQL.Plugs.TokenAuth do
  import Plug.Conn

  alias Gotcha.Player
  alias GotchaWeb.GraphQL.Token

  def generate_signed_jwt(player) do
    {:ok, token, _claims} =
      Token.generate_and_sign(%{
        "sub" => to_string(player.id)
      })

    token
  end

  @doc """
  A plug that authenticates the current player via the `Authorization` bearer token.
  - If no token is provided, halts and returns a 401 response.
  - If token is expired, halts and returns a 401 response.
  - If token is valid, sets the `current_player` on the connection assigns.
  """
  def get_current_player(conn, _opts \\ []) do
    case conn.assigns[:current_player] do
      %Player{} = _player ->
        conn

      _ ->
        verify_bearer(conn)
    end
  end

  defp get_player_by_token(token) do
    case verify_signed_jwt(token) do
      {:ok, %{"sub" => player_id}} ->
        player = Player.get(player_id)
        {:ok, %{player: player}}

      {:error, error_message} ->
        {:error, error_message}
    end
  end

  defp clear_current_player(conn) do
    conn
    |> assign(:current_player, nil)
  end

  defp verify_bearer(conn) do
    case get_req_header(conn, "authorization") do
      ["Bearer " <> token] ->
        case get_player_by_token(token) do
          {:ok, %{player: player}} ->
            assign(conn, :current_player, player)

          {:error, _message} ->
            clear_current_player(conn)
        end

      _ ->
        clear_current_player(conn)
    end
  end

  defp verify_signed_jwt(signed_token) do
    Token.verify_and_validate(signed_token)
  end
end
