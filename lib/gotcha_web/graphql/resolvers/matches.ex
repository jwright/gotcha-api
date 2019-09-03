defmodule GotchaWeb.GraphQL.Resolvers.Matches do
  alias Gotcha.{Match, MatchMaker, Repo}

  def inside(_parent, %{arena_id: arena_id}, %{context: %{current_player: current_player}}) do
    MatchMaker.match(arena_id, current_player.id)

    matches =
      Match
      |> Match.inside(arena_id)
      |> Match.with(current_player.id)
      |> Repo.all()
      |> Enum.map(fn match -> Gotcha.Repo.preload(match, [:arena, :opponent, :player]) end)

    {:ok, matches}
  end
end
