# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Milo.Repo.insert!(%Milo.SomeSchema{})
#
# mix ecto reset to reset everthing

alias Milo.Repo
alias Milo.Workouts.{Exercise, Set, Round, Workout}
alias Milo.Gyms.{Booking}
alias Milo.Accounts.{User}

#
# USERS
#

tomo =
  %User{}
  |> User.changeset(%{
    username: "tomo",
    email: "tomo@example.com",
    password: "secret"
  })
  |> Repo.insert!()

nicole =
  %User{}
  |> User.changeset(%{
    username: "nicole",
    email: "nicole@example.com",
    password: "secret"
  })
  |> Repo.insert!()

carla =
  %User{}
  |> User.changeset(%{
    username: "carla",
    email: "carla@example.com",
    password: "secret"
  })
  |> Repo.insert!()

#
# GYMS
#

#
# EXERCISES
#

ex1 =
  %Exercise{}
  |> Exercise.changeset(%{
    name: "Bench Press",
    body_part: "Chest"
    # sets: [set1, set2, set3]
  })
  |> Repo.insert!()

ex2 =
  %Exercise{}
  |> Exercise.changeset(%{
    name: "Deadlift",
    body_part: "Legs"
  })
  |> Repo.insert!()

ex3 =
  %Exercise{}
  |> Exercise.changeset(%{
    name: "Military Press",
    body_part: "Deltoids"
  })
  |> Repo.insert!()

#
# WORKOUT
#

wk1 =
  %Workout{}
  |> Workout.changeset(%{
    name: "Chest Day",
    user_id: tomo.id,
    start_date: DateTime.from_naive!(~N[2019-03-21 09:00:00], "Etc/UTC"),
    notes: "I felt really good today"
  })
  |> Repo.insert!()

#
# ROUND
#

rd1 =
  %Round{}
  |> Round.changeset(%{
    rest: 60,
    workout_id: wk1.id
    # sets: [set1, set2, set3]
  })
  |> Repo.insert!()

#
# SETS
#

set1 =
  %Set{}
  |> Set.changeset(%{
    reps: 5,
    weight: 100,
    exercise_id: ex1.id,
    round_id: 1
  })
  |> Repo.insert!()

set2 =
  %Set{}
  |> Set.changeset(%{
    reps: 6,
    weight: 90,
    exercise_id: ex1.id,
    round_id: 1
  })
  |> Repo.insert!()

set3 =
  %Set{}
  |> Set.changeset(%{
    reps: 8,
    weight: 80,
    exercise_id: ex1.id,
    round_id: 1
  })
  |> Repo.insert!()
