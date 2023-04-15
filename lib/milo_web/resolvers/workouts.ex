defmodule MiloWeb.Resolvers.Workouts do
  alias Milo.Workouts.{Exercise, Set, Round, Workout}
  alias Milo.Workouts

  def exercise(_, %{id: id}, _) do
    {:ok, Workouts.get_exercise!(id)}
  end

  def exercises(_, args, _) do
    {:ok, Workouts.list_exercises(args)}
  end

  def round(_, %{id: id}, _) do
    {:ok, Workouts.get_round!(id)}
  end

  def sets_for_round(parent, _, _) do
    {:ok, Workouts.sets_for_round(parent)}
  end

  def workout(_, %{id: id}, _) do
    {:ok, Workouts.get_workout!(id)}
  end

  def workouts(_, _args, _) do
    {:ok, Workouts.list_workouts()}
  end

  def rounds_for_workout(parent, _, _) do
    {:ok, Workouts.rounds_for_workout(parent)}
  end
end
