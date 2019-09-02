defmodule Gotcha.MatchTest do
  use ExUnit.Case, async: true

  import Gotcha.Factory

  alias Gotcha.{Match, Repo}

  setup do
    # Explicitly get a connection before each test
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
  end

  describe "Match.inside\2" do
    test "returns all matches within the specified arena" do
      arena = insert(:arena)
      match1 = insert(:match, arena: arena)
      insert(:match)
      match2 = insert(:match, arena: arena)

      result = Match |> Match.inside(arena.id) |> Repo.all()

      assert Enum.map(result, & &1.id) == [match1.id, match2.id]
    end
  end

  describe "Match.with\2" do
    test "returns all matches that have players or opponents that match the player" do
      player = insert(:player)
      insert(:match)
      match1 = insert(:match, player: player)
      insert(:match)
      match2 = insert(:match, opponent: player)

      result = Match |> Match.with(player.id) |> Repo.all()

      assert Enum.map(result, & &1.id) == [match1.id, match2.id]
    end
  end

  describe "Match.without\2" do
    test "returns all matches that do not have players or opponents that match the player" do
      player = insert(:player)
      match1 = insert(:match)
      insert(:match, player: player)
      match2 = insert(:match)
      insert(:match, opponent: player)

      result = Match |> Match.without(player.id) |> Repo.all()

      assert Enum.map(result, & &1.id) == [match1.id, match2.id]
    end
  end
end
