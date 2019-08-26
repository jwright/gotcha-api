defmodule GotchaWeb.API.GraphQL.Requests.NearbyArenasTest do
  use GotchaWeb.ConnCase, async: true

  import Gotcha.Factory
  import GotchaWeb.GraphQLHelpers

  describe "with a valid query" do
    setup do
      query = """
      {
        arenas {
          location_name
        }
      }
      """

      conn = build_conn() |> put_graphql_headers

      insert(:arena, location_name: "Wall Street")
      insert(:arena, location_name: "One World Trade Center")
      insert(:arena, location_name: "Eiffel Tower")

      [conn: conn, query: query]
    end

    test "returns the arenas within the default radius", %{
      conn: conn,
      query: query
    } do
      conn = conn |> post("/graphql", query)

      assert json_response(conn, 200) == %{
               "data" => %{
                 "arenas" => [
                   %{
                     "location_name" => "Wall Street"
                   },
                   %{
                     "location_name" => "One World Trade Center"
                   },
                   %{
                     "location_name" => "Eiffel Tower"
                   }
                 ]
               }
             }
    end
  end
end
