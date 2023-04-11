defmodule MiloWeb.Schema do
  use Absinthe.Schema
  import_types(Absinthe.Type.Custom)

  @desc "An Exercise"
  object :exercise do
    field :name, non_null(:string)
    field :body_part, non_null(:string)
    field :sets, list_of(:set)
  end

  @desc "A Set"
  object :set do
    field :weight, non_null(:integer)
    field :reps, non_null(:integer)
  end

  @desc "A Round"
  object :round do
    field :rest, non_null(:integer)
    field :sets, list_of(:set)
  end

  @desc "A Workout"
  object :workout do
    field :name, non_null(:string)
    field :start_date, non_null(:date)
    field :notes, non_null(:string)
    field :rounds, list_of(:round)
  end

  @desc "A User"
  object :user do
    field :name, non_null(:string)
    field :workouts, list_of(:workout)
  end

  # Example data
  @exercise_information %{
    "ex1" => %{id: 1, name: "Deadlift", body_part: "Legs"},
    "ex2" => %{id: 2, name: "Squat", body_part: "Legs"},
    "ex3" => %{id: 3, name: "Bench Press", body_part: "Chest"}
  }

  query do
    field :get_exercise, :exercise do
      arg(:id, non_null(:id))

      resolve(fn args, _ ->
        {:ok, Milo.Workouts.get_exercise!(args)}
      end)
    end
  end

  mutation do
    field :create_exercise, :exercise do
      arg(:name, non_null(:string))
      arg(:body_part, non_null(:string))

      resolve(fn args, _ ->
        {:ok, Milo.Workouts.create_exercise(args)}
      end)
    end
  end
end
