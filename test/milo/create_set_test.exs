defmodule Milo.CreateSetTest do
  use ExUnit.Case

  alias Milo.Workouts.Set

  describe "create_set/1" do
    test "creates a new set with valid data" do
      attrs = %{weight: 15, round_id: 1, exercise_id: 1, reps: 5}

      {:ok, set} = Milo.Workouts.create_set(attrs)

      assert set.id
      assert set.exercise_id == attrs.exercise_id
      assert set.round_id == attrs.round_id
      assert set.weight == attrs.weight
      assert set.reps == attrs.reps
    end

    test "returns an error with invalid data" do
      attrs = %{weight: 15, round_id: 1, reps: 5}

      {:error, %Ecto.Changeset{} = changeset} = Milo.Workouts.create_set(attrs)

      assert changeset.errors[:exercise_id] == ["can't be blank"]
    end
  end
end
