defmodule Gotcha.MatchFactory do
  defmacro __using__(_opts) do
    quote do
      alias Gotcha.Match

      def match_factory do
        %Match{
          arena: build(:arena),
          player: build(:player),
          opponent: build(:player),
          matched_at: DateTime.utc_now()
        }
      end
    end
  end
end
