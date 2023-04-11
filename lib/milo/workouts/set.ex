defmodule Milo.Workouts.Set do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sets" do
    field :weight, :integer
    field :reps, :integer

    belongs_to :exercise, Milo.Workouts.Exercise
    belongs_to :round, Milo.Workouts.Round

    timestamps()
  end

  def changeset(set, attrs) do
    required_fields = [:weight, :reps]

    set
    |> cast(attrs, required_fields)
    |> validate_required(required_fields)
  end
end
