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

    @desc "Matches that are in the specified arena for the current player"
    field :matches, list_of(:match) do
      arg(:arena_id, non_null(:integer), description: "The id of the arena to find the matches in")

      resolve(&Resolvers.Matches.inside/3)
    end
  end

  @desc "All mutations that can be performed within Gotcha"
  mutation do
    @desc "Authenticate a Player"
    field :login, type: :viewer do
      arg(
        :email_address,
        non_null(:string),
        description: "The email address to login with"
      )

      arg(
        :password,
        non_null(:string),
        description: "The password to login with"
      )

      resolve(&Resolvers.Auth.login/3)
    end

    @desc "Puts a Player within an Arena"
    field :play_arena, type: :arena_player do
      arg(
        :arena_id,
        non_null(:integer),
        description: "The id of the Arena to play in"
      )

      resolve(&Resolvers.ArenaPlayers.play/3)
    end

    @desc "Create a Player"
    field :register_player, type: :viewer do
      arg(
        :avatar,
        :string,
        description: "The base64 encoded avatar to create an account with"
      )

      arg(
        :email_address,
        non_null(:string),
        description: "The email address to create an account with"
      )

      arg(
        :name,
        non_null(:string),
        description: "The full name to create an account with"
      )

      arg(
        :password,
        non_null(:string),
        description: "The password to create an account with"
      )

      resolve(&Resolvers.Players.register/3)
    end
  end
end
