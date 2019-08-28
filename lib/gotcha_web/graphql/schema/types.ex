defmodule GotchaWeb.GraphQL.Schema.Types do
  use Absinthe.Schema.Notation

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

  @desc "Represents a user that can play the game"
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
end
