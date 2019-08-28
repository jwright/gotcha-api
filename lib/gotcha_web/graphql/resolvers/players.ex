defmodule GotchaWeb.GraphQL.Resolvers.Players do
  alias Gotcha.Player

  def register(_parent, args, _resolution) do
    case Player.create(args) do
      {:ok, player} ->
        {:ok, player}

      {:error, _changeset} ->
        {:error, "ERROR!"}
    end
  end
end
