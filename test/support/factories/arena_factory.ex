defmodule Gotcha.ArenaFactory do
  defmacro __using__(_opts) do
    quote do
      alias Gotcha.Arena

      def arena_factory do
        %Arena{
          location_name: "Empire State Building",
          street_address1: "350 Fifth Avenue",
          city: "New York",
          state: "NY",
          zip_code: "10118",
          latitude: 40.7488744,
          longitude: -73.9860288
        }
      end
    end
  end
end
