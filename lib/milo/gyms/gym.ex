defmodule Milo.Gyms.Gym do
  use Ecto.Schema
  import Ecto.Changeset

  schema "gym" do
    field :name, :string
    field :description, :string
    field :location, :string
    field :price_per_session, :decimal
    # field :image, :string
    # field :image_thumbnail, :string
    field :max_guests, :integer, default: 1
    field :pool, :boolean, default: false

    has_many :bookings, Milo.Gyms.Booking
    # has_many :reviews, Milo.Gyms.Review
    # has_many :equipment, Milo.Gyms.Equipment

    timestamps()
  end

  def changeset(place, attrs) do
    required_fields = [:name, :description, :location, :price_per_session]

    optional_fields = [:max_guests]

    place
    |> cast(attrs, required_fields ++ optional_fields)
    |> validate_required(required_fields)
    |> unique_constraint(:name)
  end
end
