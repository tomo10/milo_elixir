defmodule MiloWeb.Resolvers.Workouts do
  alias Milo.Workouts.{Exercise, Set, Round, Workout}
  alias Milo.Workouts

  def workouts(_, _args, _) do
    {:ok, Workouts.list_workouts()}
  end
end
