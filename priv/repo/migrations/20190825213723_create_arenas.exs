defmodule Gotcha.Repo.Migrations.CreateArenas do
  use Ecto.Migration

  def change do
    create table(:arenas) do
      add :location_name, :string
      add :street_address1, :string
      add :street_address2, :string
      add :city, :string
      add :state, :string
      add :zip_code, :string
      add :longitude, :float
      add :latitude, :float

      timestamps()
    end

  end
end
