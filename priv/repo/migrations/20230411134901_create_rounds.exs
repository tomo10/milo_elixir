defmodule Milo.Repo.Migrations.CreateRounds do
  use Ecto.Migration

  def change do
    create table(:rounds) do
      add :rest, :integer

      add :workout_id, references(:workouts), null: false

      timestamps()
    end

    create index(:rounds, [:workout_id])
  end
end
