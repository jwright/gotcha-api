# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Gotcha.Repo.insert!(%Gotcha.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

Gotcha.Repo.insert!(%Gotcha.Arena{
  location_name: "Kalahari",
  street_address1: "250 Kalahari Blvd.",
  city: "Pocono Manor",
  state: "PA",
  zip_code: "18349",
  latitude: 41.0991176,
  longitude: -75.3928016
})
