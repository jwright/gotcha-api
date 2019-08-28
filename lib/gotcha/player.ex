defmodule Gotcha.Player do
  use Gotcha.Query, module: __MODULE__

  schema "players" do
    field :avatar, :string
    field :email_address, :string
    field :name, :string
    field(:password, :string, virtual: true)
    field :password_hash, :string

    timestamps()
  end

  @doc false
  def changeset(player, attrs) do
    player
    |> cast(attrs, [:name, :email_address, :avatar, :password])
    |> validate_required([:name, :email_address, :password])
    |> validate_format(
      :email_address,
      ~r/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i,
      message: "is not a valid email address"
    )
    |> unique_constraint(:email_address)
    |> hash_password()
  end

  defp hash_password(%{changes: %{password: password}} = changeset) do
    put_change(changeset, :password_hash, Bcrypt.hash_pwd_salt(password))
  end

  defp hash_password(%{changes: %{}} = changeset), do: changeset
end
