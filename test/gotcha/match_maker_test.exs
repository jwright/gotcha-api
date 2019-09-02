defmodule Gotcha.MatchMakerTest do
  use ExUnit.Case, async: true

  import Gotcha.Factory

  alias Gotcha.{MatchMaker, Repo}

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
  end

  describe "MatchMaker.match/2" do
    setup do
      [arena: insert(:arena), player: insert(:player)]
    end

    test "it creates a match if the player is not already in a match in that arena", %{
      arena: arena,
      player: player
    } do
      opponent = insert(:player)

      insert(:arena_player,
        arena: arena,
        player: opponent,
        joined_at: DateTime.utc_now()
      )

      {:ok, match} = MatchMaker.match(arena.id, player.id)

      assert match.arena_id == arena.id
      assert match.player_id == player.id
      assert match.opponent_id == opponent.id
    end

    test "it does not create a match if there are no opponents", %{arena: arena, player: player} do
      assert {:error, :no_opponent} = MatchMaker.match(arena.id, player.id)
    end
  end
end
