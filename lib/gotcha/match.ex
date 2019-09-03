defmodule Gotcha.Match do
  use Gotcha.Query, module: __MODULE__

  alias Gotcha.{Arena, Player}

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

  def inside(query, arena_id) do
    from m in query,
      where: m.arena_id == ^arena_id
  end

  def with(query, player_id) do
    from m in query,
      where: m.player_id == ^player_id or m.opponent_id == ^player_id
  end

  def without(query, player_id) do
    from m in query,
      where: m.player_id != ^player_id and m.opponent_id != ^player_id
  end
end
