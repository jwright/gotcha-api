defmodule GotchaWeb.GraphQL.Requests.ArenaMatchesTest do
  use GotchaWeb.ConnCase, async: true

  import Gotcha.Factory
  import GotchaWeb.ConnCaseHelpers
  import GotchaWeb.GraphQLHelpers

  alias Gotcha.{Match, Repo}

  describe "with a valid query" do
    setup do
      arena = insert(:arena)
      player = insert(:player)
      insert(:arena_player, arena: arena, player: player)

      query = """
      {
        matches(arena_id: #{arena.id}) {
          player {
            name
          }
          opponent {
            name
          }
        }
      }
      """

      conn =
        build_conn()
        |> authenticate_with_jwt_token(player)
        |> put_graphql_headers

      [conn: conn, query: query, arena: arena, player: player]
    end

    test "returns the matches within the arena for the current player", %{
      conn: conn,
      query: query,
      arena: arena,
      player: player
    } do
      opponent = insert(:player)
      insert(:arena_player, arena: arena, player: opponent)
      insert(:match, arena: arena, player: player, opponent: opponent)

      conn = conn |> post("/graphql", query)

      assert json_response(conn, 200) == %{
               "data" => %{
                 "matches" => [
                   %{
                     "player" => %{
                       "name" => player.name
                     },
                     "opponent" => %{
                       "name" => opponent.name
                     }
                   }
                 ]
               }
             }
    end

    test "creates a match if one is not available", %{
      conn: conn,
      query: query,
      arena: arena,
      player: player
    } do
      opponent = insert(:player)
      insert(:arena_player, arena: arena, player: opponent)

      conn |> post("/graphql", query)

      match = Match |> Ecto.Query.last() |> Repo.one()

      assert match.player_id == player.id
      assert match.arena_id == arena.id
    end
  end
end
