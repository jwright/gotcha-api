defmodule GotchaWeb.GraphQL.Schema.Types do
  use Absinthe.Schema.Notation

  import_types(Absinthe.Type.Custom)

  alias GotchaWeb.GraphQL.Plugs.TokenAuth

  @desc "Represents a place where a game can take place"
  object :arena do
    @desc "The unique identifier for the arena."
    field(:id, non_null(:id))

    @desc "The name of the location for the arena."
    field(:location_name, non_null(:string))

    @desc "The street address of the location for the arena."
    field(:street_address1, non_null(:string))

    @desc "The secondary street address of the location for the arena."
    field(:street_address2, :string)

    @desc "The city of the location for the arena."
    field(:city, non_null(:string))

    @desc "The state abbreviation of the location for the arena."
    field(:state, non_null(:string))

    @desc "The zip code of the location for the arena."
    field(:zip_code, non_null(:string))

    @desc "The latitude of the location for the arena."
    field(:latitude, non_null(:float))

    @desc "The longitude of the location for the arena."
    field(:longitude, non_null(:float))
  end

  @desc "Represents a place where a player is playing"
  object :arena_player do
    @desc "The unique identifier for the arena and player."
    field(:id, non_null(:id))

    @desc "The place where the player is playing."
    field(:arena, non_null(:arena))

    @desc "The player that is in the arena."
    field(:player, non_null(:player))
  end

  @desc "Represents a game between two players inside an arena"
  object :match do
    @desc "The unique identifier for the match."
    field(:id, non_null(:id))

    @desc "The date and time that the match was created."
    field(:matched_at, non_null(:naive_datetime))

    @desc "The place where the match is being played."
    field(:arena, non_null(:arena))

    @desc "The player that is in the match."
    field(:player, non_null(:player))

    @desc "The opponent against the player in the match."
    field(:opponent, non_null(:player))
  end

  @desc "Represents a player who is playing the game"
  object :player do
    @desc "The unique identifier for the player."
    field(:id, non_null(:id))

    @desc "The full name of the player."
    field(:name, non_null(:string))

    @desc "The email address of the player."
    field(:email_address, non_null(:string))

    @desc "The base 64 image avatar of the player."
    field(:avatar, :string)
  end

  @desc "Represents the current user who is playing the game"
  object :viewer do
    import_fields(:player)

    @desc "The api token for the current viewer."
    field(:api_token, non_null(:string)) do
      resolve(fn player, _, _ ->
        {:ok, TokenAuth.generate_signed_jwt(player)}
      end)
    end
  end
end
