defmodule Milo.Workouts.Round do
  use Ecto.Schema
  import Ecto.Changeset

  schema "rounds" do
    field :rest, :integer

    has_many :sets, Milo.Workouts.Set
    belongs_to :workout, Milo.Workouts.Workout

    timestamps()
  end

  @spec changeset(
          {map, map}
          | %{
              :__struct__ => atom | %{:__changeset__ => map, optional(any) => any},
              optional(atom) => any
            },
          :invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}
        ) :: Ecto.Changeset.t()
  def changeset(round, attrs) do
    required_fields = [:rest]

    round
    |> cast(attrs, required_fields)
    |> validate_required(required_fields)
    |> assoc_constraint(:workout)

    # |> foreign_key_constraint(:workout_id)
  end
end
