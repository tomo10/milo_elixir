defmodule Milo.Workouts do
  @moduledoc """
  The Workouts context: public interface for finding, creating, updating, and deleting workouts / sets / rounds / exercises.
  """

  import Ecto.Query, warn: false
  alias Milo.Repo

  alias Milo.Workouts.{Exercise, Workout}

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

  def list_workouts do
    Repo.all(Workout)
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
end
