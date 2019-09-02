defmodule Gotcha.Opponent do
  alias Gotcha.{ArenaPlayer, Match, Repo}

  import Ecto.Query

  def find(arena_id, player_id) do
    players =
      Enum.map(
        Repo.all(
          from(ap in ArenaPlayer,
            join: p in assoc(ap, :player),
            where: ap.arena_id == ^arena_id and ap.player_id != ^player_id,
            preload: [:player],
            select: ap
          )
        ),
        & &1.player
      )

    matches = Match |> Match.inside(arena_id)

    players
    |> Enum.shuffle()
    |> Enum.find(fn player ->
      !(matches |> Repo.exists?()) ||
        matches |> Match.without(player.id) |> Repo.exists?()
    end)
  end
end
