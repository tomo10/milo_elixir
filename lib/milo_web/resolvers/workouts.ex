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

  def create_round(args, workout) do
    case Workouts.create_round(args, workout) do
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

  def create_set(args, round) do
    IO.inspect(args, label: "create_set args::::")
    IO.inspect(round, label: "create_set round::::")

    case Workouts.create_set(args, round) do
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
    case Workouts.create_workout(user, args) do
      {:error, changeset} ->
        {:error,
         message: "Could not create workout", details: ChangesetErrors.error_details(changeset)}

      {:ok, workout} ->
        rounds = create_rounds(args, workout)
        create_sets_from_rounds(args, rounds)
        {:ok, workout}
    end
  end

  def create_rounds(args, workout) do
    args.rounds |> Enum.map(fn round -> create_round(round, workout) end)
  end

  def create_sets_from_rounds(args, rounds) do
    IO.inspect(rounds, label: "create_sets_from_rounds rounds::::")

    rounds
    |> Enum.map(fn {:ok, round} -> map_arg_rounds_for_sets(args, round) end)
  end

  def map_arg_rounds_for_sets(args, round) do
    IO.inspect(round, label: "create_sets round::::")
    # there are no sets assoc with this round yet
    # but the sets will be in the args
    args.rounds |> Enum.map(fn round_with_sets -> create_sets(round_with_sets, round) end)
    # round.sets |> Enum.map(fn set -> create_set(set, round) end)
  end

  def create_sets(round_with_sets, round) do
    round_with_sets.sets |> Enum.map(fn set -> create_set(set, round) end)
  end
end
