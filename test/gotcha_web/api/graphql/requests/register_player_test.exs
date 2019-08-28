defmodule GotchaWeb.API.GraphQL.Requests.RegisterPlayerTest do
  use GotchaWeb.ConnCase, async: true

  import GotchaWeb.GraphQLHelpers

  alias Gotcha.{Repo, Player}

  describe "with a valid query" do
    setup do
      query = """
      mutation { registerPlayer(email_address: \"jimmyp@example.com\",
                  name: \"Jimmy Page\",
                  password: \"test\") {
        email_address
        name
      }}
      """

      conn = build_conn() |> put_graphql_headers

      [conn: conn, query: query]
    end

    test "creates the player", %{conn: conn, query: query} do
      conn |> post("/graphql", query)

      player = Player |> Ecto.Query.last() |> Repo.one()

      assert player.email_address == "jimmyp@example.com"
    end

    test "returns the details of the player", %{
      conn: conn,
      query: query
    } do
      conn = conn |> post("/graphql", query)

      assert json_response(conn, 200) == %{
               "data" => %{
                 "registerPlayer" => %{
                   "name" => "Jimmy Page",
                   "email_address" => "jimmyp@example.com"
                 }
               }
             }
    end
  end
end
