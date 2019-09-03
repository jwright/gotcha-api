defmodule Gotcha.MatchMaker do
  use Task, restart: :transient

  alias Gotcha.{Match, Opponent}

  def start_link([arena_id, player_id]) do
    Task.start_link(__MODULE__, :match, [arena_id, player_id])
  end

  def match(arena_id, player_id) do
    case Opponent.find(arena_id, player_id) do
      nil ->
        {:error, :no_opponent}

      opponent ->
        Match.create(%{
          arena_id: arena_id,
          player_id: player_id,
          opponent_id: opponent.id,
          matched_at: DateTime.utc_now()
        })
    end
  end
end
