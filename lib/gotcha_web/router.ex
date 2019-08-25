defmodule GotchaWeb.Router do
  use GotchaWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", GotchaWeb do
    pipe_through :api
  end
end
