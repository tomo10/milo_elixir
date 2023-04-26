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

  def create_round(_, args, _) do
    case Workouts.create_round(args) do
      {:error, changeset} ->
        {:error,
         message: "Could not create round", details: ChangesetErrors.error_details(changeset)}

      {:ok, round} ->
        {:ok, round}
    end
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

  @doc """
    Creates a workout and all its rounds and sets
  """
  def create_workout(_, args, %{context: %{current_user: user}}) do
    # round needs a workout to exist
    # set needs a round to exist
    # so we need to create the workout first, then the rounds, then the sets

    case Workouts.create_workout(user, args) do
      {:error, changeset} ->
        {:error,
         message: "Could not create workout", details: ChangesetErrors.error_details(changeset)}

      {:ok, workout} ->
        create_rounds(args.rounds, workout)
        {:ok, workout}
    end
  end

  def create_rounds(rounds, workout) do
    Enum.map(rounds, fn round -> Map.put(round, :workout_id, workout_id) end)
    |> Enum.map(fn round -> Workouts.create_round(round) end)
  end

  def create_sets(rounds) do
    rounds
  end
end
