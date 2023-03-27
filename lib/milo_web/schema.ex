defmodule MiloWeb.Schema do
  use Absinthe.Schema

  @desc "An Exercise"
  object :exercise do
    field :name, :string
    field :body_part, :string
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
