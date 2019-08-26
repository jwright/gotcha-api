defmodule GotchaWeb.GraphQL.Schema do
  use Absinthe.Schema

  import_types(GotchaWeb.GraphQL.Schema.Types)

  alias GotchaWeb.GraphQL.Resolvers

  @desc "All queries that can be performed within Gotcha"
  query do
    @desc "Arenas that are nearby a given location"
    field :arenas, list_of(:arena) do
      resolve(&Resolvers.Arenas.nearby/3)
    end
  end
end
