defmodule GotchaWeb.Router do
  use GotchaWeb, :router

  pipeline :graphql do
    plug(:get_current_player)
    plug(:put_graphql_context)
  end

  scope "/" do
    pipe_through(:graphql)

    forward "/graphql", Absinthe.Plug,
      schema: GotchaWeb.GraphQL.Schema,
      json_codec: Phoenix.json_library()

    forward(
      "/graphiql",
      Absinthe.Plug.GraphiQL,
      schema: GotchaWeb.GraphQL.Schema,
      json_codec: Phoenix.json_library()
    )
  end
end
