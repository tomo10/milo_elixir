defmodule Milo.Repo.Migrations.CreateSets do
  use Ecto.Migration

  def change do
    create table(:sets) do
      add :weight, :integer
      add :reps, :integer
      add :exercise_id, references(:exercises), null: false
      add :round_id, references(:rounds), null: false

      timestamps()
    end

    create index(:sets, [:exercise_id, :round_id])
  end
end
