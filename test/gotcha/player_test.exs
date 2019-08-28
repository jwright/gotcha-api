defmodule Gotcha.PlayerTest do
  use ExUnit.Case, async: true

  import Gotcha.Factory

  alias Gotcha.{Repo, Player}

  setup do
    # Explicitly get a connection before each test
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
  end

  describe "validations" do
    test "valid player is valid" do
      changeset = Player.build(params_for(:player))

      assert changeset.valid?
    end

    test "name is required" do
      changeset = Player.build(%{name: ""})

      refute changeset.valid?

      assert changeset.errors[:name] ==
               {"can't be blank", [validation: :required]}
    end

    test "email address is required" do
      changeset = Player.build(%{email_address: ""})

      refute changeset.valid?

      assert changeset.errors[:email_address] ==
               {"can't be blank", [validation: :required]}
    end

    test "email address must be a valid format" do
      changeset = Player.build(%{email_address: "someone@blah"})

      refute changeset.valid?

      assert changeset.errors[:email_address] ==
               {"is not a valid email address", [validation: :format]}
    end

    test "email address must be unique" do
      insert(:player, email_address: "jimmy@example.com", password: "secret")

      {:error, changeset} =
        Player.create(%{
          email_address: "jimmy@example.com",
          name: "Jimmy Page",
          password: "secret"
        })

      refute changeset.valid?

      assert changeset.errors[:email_address] ==
               {"has already been taken",
                [
                  constraint: :unique,
                  constraint_name: "players_email_address_index"
                ]}
    end
  end
end
