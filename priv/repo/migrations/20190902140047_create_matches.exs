defmodule Gotcha.Repo.Migrations.CreateMatches do
  use Ecto.Migration

  def change do
    create table(:matches) do
      add :matched_at, :naive_datetime
      add :arena_id, references(:arenas, on_delete: :nothing)
      add :player_id, references(:players, on_delete: :nothing)
      add :opponent_id, references(:players, on_delete: :nothing)

      timestamps()
    end

    create index(:matches, [:arena_id])
    create index(:matches, [:player_id])
    create index(:matches, [:opponent_id])
  end
end
