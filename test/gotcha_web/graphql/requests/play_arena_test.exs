defmodule GotchaWeb.GraphQL.Requests.PlayArenaTest do
  use GotchaWeb.ConnCase, async: true

  import Gotcha.Factory
  import GotchaWeb.ConnCaseHelpers
  import GotchaWeb.GraphQLHelpers

  alias Gotcha.{Repo, ArenaPlayer}

  describe "with a valid query" do
    setup do
      arena = insert(:arena)
      player = insert(:player)

      query = """
      mutation { playArena(arena_id: #{arena.id}) {
        id
        arena {
          id
          location_name
        }
        player {
          id
          name
        }
      }}
      """

      conn =
        build_conn()
        |> authenticate_with_jwt_token(player)
        |> put_graphql_headers

      [conn: conn, query: query, player: player, arena: arena]
    end

    test "creates the arena player", %{conn: conn, query: query, player: player, arena: arena} do
      conn |> post("/graphql", query)

      arena_player = ArenaPlayer |> Ecto.Query.last() |> Repo.one()
      arena_id = arena.id
      player_id = player.id

      assert arena_player.arena_id == arena_id
      assert arena_player.player_id == player_id
    end

    test "returns the details of the arena player", %{
      conn: conn,
      query: query,
      player: player,
      arena: arena
    } do
      conn = conn |> post("/graphql", query)

      arena_id = to_string(arena.id)
      player_id = to_string(player.id)

      assert %{
               "data" => %{
                 "playArena" => %{
                   "id" => _,
                   "arena" => %{
                     "id" => ^arena_id
                   },
                   "player" => %{
                     "id" => ^player_id
                   }
                 }
               }
             } = json_response(conn, 200)
    end
  end

  describe "with an existing player and arena" do
    setup do
      arena = insert(:arena)
      player = insert(:player)
      arena_player = insert(:arena_player, arena: arena, player: player)

      query = """
      mutation { playArena(arena_id: #{arena.id}) {
        id
        arena {
          id
          location_name
        }
        player {
          id
          name
        }
      }}
      """

      conn =
        build_conn()
        |> authenticate_with_jwt_token(player)
        |> put_graphql_headers

      [conn: conn, query: query, arena_player: arena_player]
    end

    test "does not create a new arena player", %{
      conn: conn,
      query: query,
      arena_player: arena_player
    } do
      conn |> post("/graphql", query)

      last_arena_player = ArenaPlayer |> Ecto.Query.last() |> Repo.one()

      assert last_arena_player.id == arena_player.id
      assert Repo.aggregate(ArenaPlayer, :count, :id) == 1
    end

    test "returns the details of the existing arena player", %{
      conn: conn,
      query: query,
      arena_player: arena_player
    } do
      conn = conn |> post("/graphql", query)

      arena_player_id = to_string(arena_player.id)

      assert %{
               "data" => %{
                 "playArena" => %{
                   "id" => ^arena_player_id
                 }
               }
             } = json_response(conn, 200)
    end
  end
end
