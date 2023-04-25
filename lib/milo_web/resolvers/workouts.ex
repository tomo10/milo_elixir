defmodule MiloWeb.Resolvers.Workouts do
  alias MiloWeb.Schema.ChangesetErrors
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

  def create_set(_, args, _) do
    case Workouts.create_set(args) do
      {:error, changeset} ->
        {:error,
         message: "Could not create set", details: ChangesetErrors.error_details(changeset)}

      {:ok, set} ->
        {:ok, set}
    end
  end

  def workout(_, %{id: id}, _) do
    {:ok, Workouts.get_workout!(id)}
  end

  def workouts(_, args, _) do
    {:ok, Workouts.list_workouts(args)}
  end

  def create_workout(_, args, %{context: %{current_user: user}}) do
    case Workouts.create_workout(user, args) do
      {:error, changeset} ->
        {:error,
         message: "Could not create workout", details: ChangesetErrors.error_details(changeset)}

      {:ok, workout} ->
        {:ok, workout}
    end
  end
end
