defmodule Gotcha.Match do
  use Gotcha.Query, module: __MODULE__

  alias Gotcha.{Arena, Match, Player, Repo}

  schema "matches" do
    field :matched_at, :naive_datetime
    belongs_to :arena, Arena
    belongs_to :opponent, Player
    belongs_to :player, Player

    timestamps()
  end

  @doc false
  def changeset(match, attrs) do
    match
    |> cast(attrs, [:arena_id, :matched_at, :player_id, :opponent_id])
    |> validate_required([:arena_id, :matched_at, :player_id, :opponent_id])
  end

  def inside(arena_id) do
    Match
    |> where(arena_id: ^arena_id)
    |> Repo.all()
  end

  def without(player_id) do
    from(m in Match,
      where: m.player_id != ^player_id and m.opponent_id != ^player_id,
      select: m
    )
    |> Repo.all()
  end
end
