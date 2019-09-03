defmodule GotchaWeb.ConnCaseHelpers do
  @moduledoc """
  Test helpers for any ConnCase test.
  """

  import Plug.Conn

  def authenticate_with_jwt_token(conn, player) do
    token = GotchaWeb.GraphQL.Plugs.TokenAuth.generate_signed_jwt(player)
    put_req_header(conn, "authorization", "Bearer #{token}")
  end
end
