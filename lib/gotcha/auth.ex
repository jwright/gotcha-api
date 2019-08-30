defmodule Gotcha.Auth do
  alias Gotcha.{Repo, Player}

  import Ecto.Query

  def login(email_address, password) do
    player =
      Repo.one(
        from(
          p in Player,
          where:
            fragment("lower(?)", p.email_address) ==
              ^String.downcase(email_address)
        )
      )

    validate_password(player, password)
  end

  defp validate_password(%Player{password_hash: password_hash} = player, password) do
    if Bcrypt.verify_pass(password, password_hash) do
      {:ok, player}
    else
      {:error, :unauthorized}
    end
  end

  defp validate_password(nil, _) do
    Bcrypt.no_user_verify()
    {:error, :not_found}
  end
end
