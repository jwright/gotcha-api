defmodule Gotcha.PlayerFactory do
  defmacro __using__(_opts) do
    quote do
      alias Gotcha.Player

      def player_factory do
        %Player{
          name: Faker.Name.name(),
          email_address: Faker.Internet.email()
        }
      end
    end
  end
end
