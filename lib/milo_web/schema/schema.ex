defmodule MiloWeb.Schema do
  use Absinthe.Schema
  alias MiloWeb.Resolvers
  import_types(Absinthe.Type.Custom)
  import Absinthe.Resolution.Helpers, only: [dataloader: 3, dataloader: 1]

  # TODO
  # sign in and sign up mutations before can query user
  # then carry on with createWorkout mutation

  query do
    @desc "Ger a user by their id"
    field :me, :user do
      resolve(&Resolvers.Accounts.me/3)
    end

    @desc "Get an exercise by its id"
    field :exercise, :exercise do
      arg(:id, non_null(:id))

      resolve(&Resolvers.Workouts.exercise/3)
    end

    @desc "Get all exercises"
    field :exercises, list_of(:exercise) do
      arg(:limit, :integer, default_value: 10)

      resolve(&Resolvers.Workouts.exercises/3)
    end

    @desc "Get a set by its id"
    field :set, :set do
      arg(:id, non_null(:id))

      resolve(&Resolvers.Workouts.set/3)
    end

    @desc "Get a workout by its id"
    field :workout, :workout do
      arg(:id, non_null(:id))

      resolve(&Resolvers.Workouts.workout/3)
    end

    @desc "Get all workouts"
    field :workouts, list_of(:workout) do
      arg(:limit, :integer, default_value: 10)

      resolve(&Resolvers.Workouts.workouts/3)
    end

    @desc "Get a round by its id"
    field :round, :round do
      arg(:id, non_null(:id))

      resolve(&Resolvers.Workouts.round/3)
    end
  end

  # MUTATIONS

  mutation do
    field :create_exercise, :exercise do
      arg(:name, non_null(:string))
      arg(:body_part, non_null(:string))

      resolve(fn args, _ ->
        {:ok, Milo.Workouts.create_exercise(args)}
      end)
    end

    field :create_set, :set do
      arg(:exercise_id, non_null(:id))
      arg(:round_id, non_null(:id))
      arg(:reps, non_null(:integer))
      arg(:weight, non_null(:integer))

      resolve(&Resolvers.Workouts.create_set/3)
    end

    field :create_workout, :workout do
      arg(:name, non_null(:string))
      arg(:start_date, non_null(:date))
      arg(:notes, non_null(:string))

      resolve(&Resolvers.Workouts.create_workout/3)
    end

    @desc "Create a user account"
    field :signup, :session do
      arg(:username, non_null(:string))
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))

      resolve(&Resolvers.Accounts.signup/3)
    end

    @desf "Sign in to a user account"
    field :signin, :session do
      arg(:username, non_null(:string))
      arg(:password, non_null(:string))

      resolve(&Resolvers.Accounts.signin/3)
    end
  end

  # MODELS

  @desc "An Exercise"
  object :exercise do
    field :name, non_null(:string)
    field :body_part, non_null(:string)

    field :sets, list_of(:set), resolve: dataloader(Workouts)
  end

  @desc "A Set"
  object :set do
    field :weight, non_null(:integer)
    field :reps, non_null(:integer)

    field :exercise, non_null(:exercise), resolve: dataloader(Workouts)
  end

  @desc "A Round"
  object :round do
    field :rest, non_null(:integer)

    field :sets, list_of(:set), resolve: dataloader(Workouts)
  end

  @desc "A Workout"
  object :workout do
    field :name, non_null(:string)
    field :start_date, non_null(:date)
    field :notes, non_null(:string)

    field :rounds, list_of(:round), resolve: dataloader(Workouts)
  end

  @desc "A User"
  object :user do
    field :username, non_null(:string)
    field :email, non_null(:string)
    field :workouts, list_of(:workout)
  end

  # NB schema objects dont need to tally up with contexts. ie sesssion doesnt
  @desc "A session"
  object :session do
    field :user, non_null(:user)
    field :token, non_null(:string)
  end

  # CONTEXT

  def context(ctx) do
    IO.inspect(ctx, label: "CTX")

    loader =
      Dataloader.new()
      |> Dataloader.add_source(Workouts, Milo.Workouts.datasource())

    # |> Dataloader.add_source(Accounts, Milo.Accounts.datasource())

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end
end
