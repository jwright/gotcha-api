defmodule Gotcha.ArenaTest do
  use ExUnit.Case, async: true

  import Gotcha.Factory

  alias Gotcha.{Repo, Arena}

  setup do
    # Explicitly get a connection before each test
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
  end

  describe ".near" do
    test "returns all arenas within a specific point and radius" do
      arena1 = insert(:arena, latitude: 40.706877, longitude: -74.011265)
      insert(:arena, latitude: 41.651031, longitude: -83.541939)
      arena2 = insert(:arena, latitude: 40.712742, longitude: -74.013382)

      nearby = Arena.near(40.7087676, -74.0185012, 25)

      assert Enum.map(nearby, & &1.id) == [arena1.id, arena2.id]
    end
  end

  describe "validations" do
    test "valid arena is valid" do
      changeset = Arena.build(params_for(:arena))

      assert changeset.valid?
    end

    test "location name is required" do
      changeset = Arena.build(%{location_name: ""})

      refute changeset.valid?

      assert changeset.errors[:location_name] ==
               {"can't be blank", [validation: :required]}
    end

    test "street address is required" do
      changeset = Arena.build(%{street_address1: ""})

      refute changeset.valid?

      assert changeset.errors[:street_address1] ==
               {"can't be blank", [validation: :required]}
    end

    test "city is required" do
      changeset = Arena.build(%{city: ""})

      refute changeset.valid?

      assert changeset.errors[:city] ==
               {"can't be blank", [validation: :required]}
    end

    test "state is required" do
      changeset = Arena.build(%{state: ""})

      refute changeset.valid?

      assert changeset.errors[:state] ==
               {"can't be blank", [validation: :required]}
    end

    test "state is required to be a length of 2" do
      changeset = Arena.build(%{state: "Ohio"})

      refute changeset.valid?

      assert changeset.errors[:state] ==
               {"should be %{count} character(s)",
                [count: 2, validation: :length, kind: :is, type: :string]}
    end

    test "zip code is required" do
      changeset = Arena.build(%{zip_code: ""})

      refute changeset.valid?

      assert changeset.errors[:zip_code] ==
               {"can't be blank", [validation: :required]}
    end

    test "longitude is required" do
      changeset = Arena.build(%{longitude: nil})

      refute changeset.valid?

      assert changeset.errors[:longitude] ==
               {"can't be blank", [validation: :required]}
    end

    test "longitude is a valid range" do
      changeset = Arena.build(%{longitude: -181})

      refute changeset.valid?

      assert elem(changeset.errors[:longitude], 0) == "is invalid"
    end

    test "latitude is required" do
      changeset = Arena.build(%{latitude: nil})

      refute changeset.valid?

      assert changeset.errors[:latitude] ==
               {"can't be blank", [validation: :required]}
    end

    test "latitude is a valid range" do
      changeset = Arena.build(%{latitude: -91})

      refute changeset.valid?

      assert elem(changeset.errors[:latitude], 0) == "is invalid"
    end
  end
end
