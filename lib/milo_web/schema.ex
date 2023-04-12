defmodule MiloWeb.Schema do
  use Absinthe.Schema
  import_types(Absinthe.Type.Custom)

  query do
    @desc "Get an exercise by its id"
    field :exercise, :exercise do
      arg(:id, non_null(:id))

      resolve(fn _, %{id: id}, _ ->
        {:ok, Milo.Workouts.get_exercise!(id)}
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
end
