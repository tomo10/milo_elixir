defmodule Milo.Exercise.Info do
  use Ecto.Schema
  import Ecto.Changeset

  schema "information" do
    field :body_part, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(info, attrs) do
    info
    |> cast(attrs, [:name, :body_part])
    |> validate_required([:name, :body_part])
  end
end
