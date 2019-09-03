defmodule Gotcha.ArenaPlayerTest do
  use ExUnit.Case, async: true

  import Gotcha.Factory

  alias Gotcha.{Repo, ArenaPlayer}

  setup do
    # Explicitly get a connection before each test
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
  end

  describe ".for" do
    test "returns the first arena player for the arena and player" do
      insert(:arena_player)
      arena_player = insert(:arena_player)
      insert(:arena_player)

      result = ArenaPlayer.for(arena_player.arena_id, arena_player.player_id)

      assert result.id == arena_player.id
    end
  end
end
