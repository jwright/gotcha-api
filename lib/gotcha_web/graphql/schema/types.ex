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
end
