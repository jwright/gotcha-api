defmodule Gotcha.ArenaPlayer do
  use Gotcha.Query, module: __MODULE__

  alias Gotcha.{Arena, ArenaPlayer, Player, Repo}

  schema "arena_players" do
    field :joined_at, :naive_datetime
    belongs_to :arena, Arena
    belongs_to :player, Player

    timestamps()
  end

  @doc false
  def changeset(arena_player, attrs) do
    arena_player
    |> cast(attrs, [:arena_id, :player_id, :joined_at])
    |> validate_required([:arena_id, :player_id, :joined_at])
  end

  def for(arena_id, player_id) do
    ArenaPlayer
    |> where(arena_id: ^arena_id, player_id: ^player_id)
    |> Repo.one()
  end
end
