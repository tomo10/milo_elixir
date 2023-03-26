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
    field :exercise_info, :exercise do
      arg(:id, non_null(:id))

      resolve(fn %{id: exercise_id}, _ ->
        {:ok, @exercise_information[exercise_id]}
      end)
    end
  end
end
