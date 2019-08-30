defmodule GotchaWeb.API.GraphQL.Requests.LoginTest do
  use GotchaWeb.ConnCase, async: true

  alias Gotcha.Player

  import GotchaWeb.GraphQLHelpers

  describe "with a valid query" do
    setup do
      {:ok, player} =
        Player.create(%{
          email_address: "jimmyp@example.com",
          name: "Jimmy Page",
          password: "password"
        })

      query = """
      mutation { login(email_address: \"jimmyp@example.com\",
                  password: \"password\") {
        id
        email_address
        name
      }}
      """

      conn = build_conn() |> put_graphql_headers

      [conn: conn, query: query, player: player]
    end

    test "returns the details of the player", %{
      conn: conn,
      query: query,
      player: player
    } do
      conn = conn |> post("/graphql", query)

      assert json_response(conn, 200) == %{
               "data" => %{
                 "login" => %{
                   "id" => to_string(player.id),
                   "email_address" => player.email_address,
                   "name" => player.name
                 }
               }
             }
    end
  end
end
