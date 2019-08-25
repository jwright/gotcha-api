defmodule Gotcha.Arena do
  use Gotcha.Query, module: __MODULE__

  schema "arenas" do
    field :city, :string
    field :latitude, :float
    field :location_name, :string
    field :longitude, :float
    field :state, :string
    field :street_address1, :string
    field :street_address2, :string
    field :zip_code, :string

    timestamps()
  end

  @doc false
  def changeset(arena, attrs) do
    arena
    |> cast(attrs, [
      :location_name,
      :street_address1,
      :street_address2,
      :city,
      :state,
      :zip_code,
      :longitude,
      :latitude
    ])
    |> validate_required([
      :location_name,
      :street_address1,
      :city,
      :state,
      :zip_code,
      :longitude,
      :latitude
    ])
    |> validate_length(:state, is: 2)
    |> validate_inclusion(:latitude, -90..90)
    |> validate_inclusion(:longitude, -180..180)
  end
end
