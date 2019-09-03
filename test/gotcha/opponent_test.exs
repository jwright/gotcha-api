defmodule Gotcha.OpponentTest do
  use ExUnit.Case, async: true

  import Gotcha.Factory

  alias Gotcha.{Opponent, Repo}

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)

    [arena: insert(:arena), player1: insert(:player), player2: insert(:player)]
  end

  describe "Opponent.find/2" do
    test "returns an ok tuple if the opponent was found", %{
      arena: arena,
      player1: player1,
      player2: player2
    } do
      insert(:arena_player,
        arena: arena,
        player: player1,
        joined_at: DateTime.utc_now()
      )

      insert(:arena_player,
        arena: arena,
        player: player2,
        joined_at: DateTime.utc_now()
      )

      opponent = Opponent.find(arena.id, player1.id)

      assert opponent.id == player2.id
    end

    test "does not return players in matches", %{arena: arena, player1: player1, player2: player2} do
      player3 = insert(:player)

      insert(:arena_player,
        arena: arena,
        player: player1,
        joined_at: DateTime.utc_now()
      )

      insert(:arena_player,
        arena: arena,
        player: player2,
        joined_at: DateTime.utc_now()
      )

      insert(:arena_player,
        arena: arena,
        player: player3,
        joined_at: DateTime.utc_now()
      )

      insert(:match, arena: arena, player: player1, opponent: player3)

      opponent = Opponent.find(arena.id, player1.id)

      assert opponent.id == player2.id
    end

    test "returns an error tuple if the opponent is already in a match", %{
      arena: arena,
      player1: player1,
      player2: player2
    } do
      insert(:arena_player,
        arena: arena,
        player: player1,
        joined_at: DateTime.utc_now()
      )

      insert(:arena_player,
        arena: arena,
        player: player2,
        joined_at: DateTime.utc_now()
      )

      insert(:match, arena: arena, player: player1, opponent: player2)

      assert nil == Opponent.find(arena.id, player1.id)
    end

    test "returns an error tuple if there are no more opponents available", %{
      arena: arena,
      player1: player1
    } do
      assert nil == Opponent.find(arena.id, player1.id)
    end
  end
end
