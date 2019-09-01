defmodule Gotcha.ArenaPlayerFactory do
  defmacro __using__(_opts) do
    quote do
      alias Gotcha.ArenaPlayer

      def arena_player_factory do
        %ArenaPlayer{
          arena: build(:arena),
          player: build(:player),
          joined_at: DateTime.utc_now()
        }
      end
    end
  end
end
