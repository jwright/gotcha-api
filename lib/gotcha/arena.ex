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
    |> validate_change(:latitude, fn :latitude, latitude ->
      if latitude > -91 && latitude < 91, do: [], else: [latitude: "is invalid"]
    end)
    |> validate_change(:longitude, fn :longitude, longitude ->
      if longitude > -181 && longitude < 181, do: [], else: [longitude: "is invalid"]
    end)
  end

  def near(latitude, longitude, radius) do
    radius_in_meters = Kernel.trunc(radius * 1609.34)
    current_location = [latitude, longitude]

    # TODO: This is not ideal as we are pulling down all of the locations. We don't
    # want to complicate this with PostGIS yet

    __MODULE__
    |> Repo.all()
    |> Enum.filter(fn arena ->
      Geocalc.within?(radius_in_meters, current_location, [arena.latitude, arena.longitude])
    end)
  end
end
