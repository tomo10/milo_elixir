defmodule MiloWeb.Resolvers.Workouts do
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

  def set(_, %{id: id}, _) do
    {:ok, Workouts.get_set!(id)}
  end

  # def sets(_, _args, _) do
  #   {:ok, Workouts.list_sets()}
  # end

  def workout(_, %{id: id}, _) do
    {:ok, Workouts.get_workout!(id)}
  end

  def workouts(_, args, _) do
    {:ok, Workouts.list_workouts(args)}
  end
end
