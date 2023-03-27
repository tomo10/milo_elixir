defmodule Milo.Gyms.Booking do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  schema "bookings" do
    field :start_time, :date
    field :end_time, :date
    field :state, :string, default: "unreserved"
    field :total_price, :decimal

    belongs_to :gym, Milo.Gyms.Gym
    belongs_to :user, Milo.Accounts.User

    timestamps()
  end

  def changeset(booking, attrs) do
    required_fields = [:start_time, :end_time, :gym_id]
    optional_fields = [:state]
    # add in the priate functions validating start and end times

    booking
    |> cast(attrs, required_fields ++ optional_fields)
    |> validate_required(required_fields)
    |> validate_start_before_end()
    |> assoc_constraint(:gym)
    |> assoc_constraint(:user)
  end

  def cancel_changeset(booking, attrs) do
    booking
    |> cast(attrs, [:state])
    |> validate_required([:state])
  end

  defp validate_start_before_end(changeset) do
    case changeset.valid? do
      true ->
        start_time = get_field(changeset, :start_time)
        end_time = get_field(changeset, :end_time)

        case Date.compare(start_time, end_time) do
          :gt ->
            add_error(changeset, :start_time, "Cannot be after :end_time")

          _ ->
            changeset
        end

      _ ->
        changeset
    end
  end
end
