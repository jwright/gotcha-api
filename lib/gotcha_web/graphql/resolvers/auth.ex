defmodule GotchaWeb.GraphQL.Resolvers.Auth do
  alias Gotcha.Auth

  def login(_parent, args, _resolution) do
    case(Auth.login(args[:email_address], args[:password])) do
      {:ok, player} ->
        {:ok, player}

      {:error, _} ->
        {:error, message: "Invalid email address or password"}
    end
  end
end
