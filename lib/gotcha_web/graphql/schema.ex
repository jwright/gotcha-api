defmodule GotchaWeb.GraphQL.Schema do
  use Absinthe.Schema

  import_types(GotchaWeb.GraphQL.Schema.Types)

  alias GotchaWeb.GraphQL.Resolvers

  @desc "All queries that can be performed within Gotcha"
  query do
    @desc "Arenas that are nearby a given location"
    field :arenas, list_of(:arena) do
      arg(:latitude, non_null(:float), description: "The latitude to use for the center point")
      arg(:longitude, non_null(:float), description: "The longitude to use for the center point")

      arg(:radius, :integer,
        default_value: 25,
        description:
          "The number of miles to use for the radius to find the arenas. Default to 25 miles."
      )

      resolve(&Resolvers.Arenas.nearby/3)
    end
  end
end
