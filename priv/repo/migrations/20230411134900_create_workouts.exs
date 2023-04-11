defmodule Milo.Repo.Migrations.CreateWorkouts do
  use Ecto.Migration

  def change do
    create table(:workouts) do
      add :name, :string
      add :start_date, :date
      add :notes, :string
      # add :user_id, references(:users), null: false

      timestamps()
    end

    # create index(:workouts, [:user_id])
  end
end
