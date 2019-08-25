defmodule GotchaWeb.API.GraphQL.Requests.NearbyArenasTest do
  use GotchaWeb.ConnCase, async: true

  describe "with a valid query" do
    setup do
      query = """
      query { arenas {
        id
        location_name
      }
      """

      conn = build_conn()
      arena1 = insert(:arena)
      arena2 = insert(:arena)
      arena3 = insert(:arena)

      [conn: conn, query: query, arenas: [arena1, arena2, arena3]]
    end

    test "returns the arenas within the default radius", %{conn: conn, query: query, arenas: arenas} do
      conn = conn |> post("/graphql", query)

      assert json_response(conn, 200) == %{
        "data" => {
          "arenas" => [{
            "id" => arenas[0].id,
          }]
        }
      }
    end

    test "responds to the query with the fields" do
    end
  end
end
