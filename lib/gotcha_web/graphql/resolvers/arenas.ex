defmodule GotchaWeb.GraphQL.Resolvers.Arenas do
  alias Gotcha.{Arena, Repo}

  def nearby(_parent, _args, _resolution) do
    {:ok, Arena |> Repo.all()}
  end
end
