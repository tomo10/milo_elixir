defmodule Milo.Repo.Migrations.CreateExercises do
  use Ecto.Migration

  def change do
    create table(:exercises) do
      add :name, :string
      add :body_part, :string

      timestamps()
    end
  end
end
