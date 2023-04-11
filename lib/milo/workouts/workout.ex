defmodule Milo.Workouts.Workout do
  use Ecto.Schema
  import Ecto.Changeset

  schema "workouts" do
    field :name, :string
    field :start_date, :date
    field :notes, :string

    # belongs_to :user, Milo.Accounts.User
    has_many :rounds, Milo.Workouts.Round

    timestamps()
  end

  def changeset(workout, attrs) do
    required_fields = [:name, :start_date]

    workout
    |> cast(attrs, required_fields)
    |> validate_required(required_fields)

    # |> assoc_constraint(:user)
  end
end
