defmodule Gotcha.AuthTest do
  use ExUnit.Case, async: true
  doctest Gotcha.Auth

  alias Gotcha.{Repo, Auth, Player}

  setup do
    # Explicitly get a connection before each test
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
  end

  describe ".login" do
    test "success" do
      {:ok, player} =
        Player.create(%{
          email_address: "jimmy@example.com",
          name: "Jimmy Page",
          password: "secret"
        })

      id = player.id

      assert {:ok, %{id: ^id}} = Auth.login("jimmy@example.com", "secret")
    end

    test "failure" do
      {:ok, _} =
        Player.create(%{
          email_address: "jimmy@example.com",
          name: "Jimmy Page",
          password: "secret"
        })

      assert {:error, :unauthorized} = Auth.login("jimmy@example.com", "blah")
      assert {:error, :not_found} = Auth.login("someone@example.com", "blah")
    end
  end
end
