defmodule Milo.Workouts do
  @moduledoc """
  The Workouts context: public interface for finding, creating, updating, and deleting workouts / sets / rounds / exercises.
  """

  import Ecto.Query, warn: false
  alias Milo.Workouts.Round
  alias Milo.Repo

  alias Milo.Workouts.{Exercise, Workout, Set}

  @doc """
  Returns a list of exercises matching the given `criteria`.

  Example Criteria:

  [{:limit, 15}, {:order, :asc}, {:filter, [{:matching, "lake"}, {:wifi, true}, {:guest_count, 3}]}]
  """
  def list_exercises(criteria) do
    query = from(e in Exercise)

    Enum.reduce(criteria, query, fn
      {:limit, limit}, query ->
        from e in query, limit: ^limit
    end)
    |> Repo.all()
  end

  @doc """
  Returns the list of workouts.

  ## Examples

      iex> list_exercises()
      [%Workouts{}, ...]

  """

  def list_workouts(criteria) do
    query = from(w in Workout)

    Enum.reduce(criteria, query, fn
      {:limit, limit}, query ->
        from w in query, limit: ^limit
    end)
    |> Repo.all()
  end

  def list_sets do
    Repo.all(Set)
  end

  @doc """
  Gets a single exercise.

  Raises `Ecto.NoResultsError` if the exercise does not exist.

  ## Examples

      iex> get_exercise!(123)
      %Info{}

      iex> get_exercise!(456)
      ** (Ecto.NoResultsError)

  """
  def get_exercise!(id), do: Repo.get!(Exercise, id)

  def get_round!(id), do: Repo.get!(Round, id)

  def get_set!(id), do: Repo.get!(Set, id)

  def get_workout!(id), do: Repo.get!(Workout, id)

  @doc """
  Creates an exercise.

  ## Examples

      iex> create_exercise(%{field: value})
      {:ok, %Exercise{}}

      iex> create_exercise(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_exercise(attrs \\ %{}) do
    %Exercise{}
    |> Exercise.changeset(attrs)
    |> Repo.insert()
  end

  def create_set(attrs) do
    IO.inspect(attrs, label: "create_set attrs")

    %Set{}
    |> Set.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:exercise, Milo.Workouts.get_exercise!(attrs.exercise_id))
    |> Ecto.Changeset.put_assoc(:round, Milo.Workouts.get_round!(attrs.round_id))
    |> Repo.insert()
  end

  # def create_workout(attrs) do
  #   IO.inspect(attrs, label: "create_workout attrs")

  #   %Workout{}
  #   |> Workout.changeset(attrs)
  #   |> Repo.insert()
  # end

  @doc """
  Updates an exercise.

  ## Examples

      iex> update_exercise(exercise, %{field: new_value})
      {:ok, %Exercise{}}

      iex> update_exercise(exercise, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_exercise(%Exercise{} = exercise, attrs) do
    exercise
    |> Exercise.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes an exercise.

  ## Examples

      iex> delete_exercise(exercise)
      {:ok, %Exercise{}}

      iex> delete_exercise(exercise)
      {:error, %Ecto.Changeset{}}

  """
  def delete_exercise(%Exercise{} = exercise) do
    Repo.delete(exercise)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking exercise changes.

  ## Examples

      iex> change_exercise(exercise)
      %Ecto.Changeset{data: %Exercise{}}

  """
  def change_exercise(%Exercise{} = exercise, attrs \\ %{}) do
    Exercise.changeset(exercise, attrs)
  end

  # dataloader functions. These essetnailly allow you fine grain control over what data is loaded through dataloader
  def datasource() do
    Dataloader.Ecto.new(Repo, query: &query/2)
  end

  # this is an example from getaways to query booking by reserved state. we could apply to ex and bodyParts say
  # 4 min of vid 13. Adding scope: :place means that query would only apply to the place model dataloader query in shcema
  # scope naming is arbitrary

  # def query(Exercise, %{scope: :place}) do
  #   Exercise
  #   |> where(state: "reserved")
  #   |> order_by([desc: :start_date])
  # end

  def query(queryable, _) do
    queryable
  end
end
