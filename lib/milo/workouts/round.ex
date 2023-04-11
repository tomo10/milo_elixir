defmodule Milo.Workouts.Round do
  use Ecto.Schema
  import Ecto.Changeset

  schema "rounds" do
    field :rest, :integer

    has_many :sets, Milo.Workouts.Set
    belongs_to :workout, Milo.Workouts.Workout

    timestamps()
  end

  def changeset(round, attrs) do
    required_fields = [:rest]

    round
    |> cast(attrs, required_fields)
    |> validate_required(required_fields)
    |> assoc_constraint(:workout)
  end
end
