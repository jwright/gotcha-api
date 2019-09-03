defmodule GotchaWeb.GraphQL.Plugs.GraphQL do
  alias Gotcha.Player

  def put_graphql_context(conn, _opts) do
    current_player = conn.assigns[:current_player]
    Absinthe.Plug.put_options(conn, context: build_context(current_player))
  end

  defp build_context(%Player{} = player) do
    %{current_player: player}
  end

  defp build_context(_) do
    %{}
  end
end
