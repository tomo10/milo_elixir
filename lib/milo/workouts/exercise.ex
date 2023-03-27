defmodule Milo.Workouts.Exercise do
  @moduledoc """
  Creates an exercise struct. Requires 2 things a schema and a changeset function
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "exercises" do
    field :name, :string
    field :body_part, :string

    timestamps()
  end

  def changeset(exercise, attrs) do
    required_fields = [:name, :body_part]

    exercise |> cast(attrs, required_fields)
  end
end
