defmodule GotchaWeb.GraphQL.Token do
  use Joken.Config, default_exp: 12 * 30 * 60, default_iss: "Gotcha"

  @impl true
  def token_config do
    default_claims()
    |> add_claim("sub", nil, &validate_player_id/2)
  end

  defp validate_player_id(value, claims) do
    to_string(value) == claims["sub"]
  end
end
