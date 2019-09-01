defmodule GotchaWeb.GraphQL.Resolvers.ArenaPlayers do
  alias Gotcha.ArenaPlayer

  def play(_parent, %{arena_id: arena_id}, %{context: %{current_player: current_player}}) do
    arena_player =
      existing_arena_player(arena_id, current_player.id) ||
        new_arena_player(arena_id, current_player.id)

    arena_player = Gotcha.Repo.preload(arena_player, [:arena, :player])

    {:ok, arena_player}
  end

  defp existing_arena_player(arena_id, player_id) do
    ArenaPlayer.for(arena_id, player_id)
  end

  defp new_arena_player(arena_id, player_id) do
    {:ok, arena_player} =
      ArenaPlayer.create(%{
        arena_id: arena_id,
        player_id: player_id,
        joined_at: DateTime.utc_now()
      })

    arena_player
  end
end
