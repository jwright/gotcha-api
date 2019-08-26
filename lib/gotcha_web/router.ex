defmodule GotchaWeb.Router do
  use GotchaWeb, :router

  forward "/graphql", Absinthe.Plug, schema: GotchaWeb.GraphQL.Schema

  forward(
    "/graphiql",
    Absinthe.Plug.GraphiQL,
    schema: GotchaWeb.GraphQL.Schema,
    json_codec: Phoenix.json_library()
  )
end
