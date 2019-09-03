defmodule Gotcha.Repo.Migrations.CreateArenaPlayers do
  use Ecto.Migration

  def change do
    create table(:arena_players) do
      add :joined_at, :naive_datetime
      add :arena_id, references(:arenas, on_delete: :nothing)
      add :player_id, references(:players, on_delete: :nothing)

      timestamps()
    end

    create index(:arena_players, [:arena_id])
    create index(:arena_players, [:player_id])
  end
end
