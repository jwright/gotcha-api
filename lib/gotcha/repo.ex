defmodule Gotcha.Repo do
  use Ecto.Repo,
    otp_app: :gotcha,
    adapter: Ecto.Adapters.Postgres
end
