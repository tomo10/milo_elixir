defmodule Milo.Repo.Migrations.CreateWorkouts do
  use Ecto.Migration

  def change do
    create table(:workouts) do
      add :name, :string
      add :start_date, :date
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:workouts, [:user_id])
  end
end
