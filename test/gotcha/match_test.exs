defmodule Gotcha.MatchTest do
  use ExUnit.Case, async: true

  import Gotcha.Factory

  alias Gotcha.{Match, Repo}

  setup do
    # Explicitly get a connection before each test
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
  end

  describe ".inside" do
    test "returns all matches within the specified arena" do
      arena = insert(:arena)
      match1 = insert(:match, arena: arena)
      insert(:match)
      match2 = insert(:match, arena: arena)

      result = Match.inside(arena.id)

      assert Enum.map(result, & &1.id) == [match1.id, match2.id]
    end
  end
end
