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
alias Milo.Workouts.{Exercise}
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
