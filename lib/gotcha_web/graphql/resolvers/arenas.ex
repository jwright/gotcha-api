defmodule GotchaWeb.GraphQL.Resolvers.Arenas do
  alias Gotcha.Arena

  def nearby(_parent, %{latitude: latitude, longitude: longitude, radius: radius}, _resolution) do
    {:ok, Arena.near(latitude, longitude, radius)}
  end
end
