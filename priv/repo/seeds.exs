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
# Need to add equipment field to exercises
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

ex4 =
  %Exercise{}
  |> Exercise.changeset(%{
    name: "Squat",
    body_part: "Legs"
  })
  |> Repo.insert!()

ex5 =
  %Exercise{}
  |> Exercise.changeset(%{
    name: "Bicep Curls",
    body_part: "Arms"
  })
  |> Repo.insert!()

ex6 =
  %Exercise{}
  |> Exercise.changeset(%{
    name: "Lunges",
    body_part: "Legs"
  })
  |> Repo.insert!()

ex7 =
  %Exercise{}
  |> Exercise.changeset(%{
    name: "Pull-ups",
    body_part: "Back"
  })
  |> Repo.insert!()

ex8 =
  %Exercise{}
  |> Exercise.changeset(%{
    name: "Tricep Dips",
    body_part: "Arms"
  })
  |> Repo.insert!()

ex9 =
  %Exercise{}
  |> Exercise.changeset(%{
    name: "Shoulder Press",
    body_part: "Deltoids"
  })
  |> Repo.insert!()

ex10 =
  %Exercise{}
  |> Exercise.changeset(%{
    name: "Hamstring Curls",
    body_part: "Legs"
  })
  |> Repo.insert!()

ex11 =
  %Exercise{}
  |> Exercise.changeset(%{
    name: "Chest Flyes",
    body_part: "Chest"
  })
  |> Repo.insert!()

ex12 =
  %Exercise{}
  |> Exercise.changeset(%{
    name: "Plank",
    body_part: "Core"
  })
  |> Repo.insert!()

ex13 =
  %Exercise{}
  |> Exercise.changeset(%{
    name: "Dumbbell Rows",
    body_part: "Back"
  })
  |> Repo.insert!()

ex14 =
  %Exercise{}
  |> Exercise.changeset(%{
    name: "Leg Press",
    body_part: "Legs"
  })
  |> Repo.insert!()

ex15 =
  %Exercise{}
  |> Exercise.changeset(%{
    name: "Barbell Rows",
    body_part: "Back"
  })
  |> Repo.insert!()

ex16 =
  %Exercise{}
  |> Exercise.changeset(%{
    name: "Incline Bench Press",
    body_part: "Chest"
  })
  |> Repo.insert!()

ex17 =
  %Exercise{}
  |> Exercise.changeset(%{
    name: "Lateral Raises",
    body_part: "Deltoids"
  })
  |> Repo.insert!()

ex18 =
  %Exercise{}
  |> Exercise.changeset(%{
    name: "Russian Twists",
    body_part: "Core"
  })
  |> Repo.insert!()

ex19 =
  %Exercise{}
  |> Exercise.changeset(%{
    name: "Leg Extensions",
    body_part: "Legs"
  })
  |> Repo.insert!()

#
# ROUNDS
#

rd1 = %Round{
  rest: 60,
  workout_id: 1,
  sets: [
    %Set{
      reps: 5,
      weight: 100,
      exercise: ex1
    },
    %Set{
      reps: 6,
      weight: 90,
      exercise: ex1
    },
    %Set{
      reps: 8,
      weight: 80,
      exercise: ex1
    }
  ]
}

rd2 = %Round{
  rest: 60,
  workout_id: 2,
  sets: [
    %Set{
      reps: 2,
      weight: 10,
      exercise: ex3
    },
    %Set{
      reps: 6,
      weight: 12,
      exercise: ex3
    },
    %Set{
      reps: 8,
      weight: 14,
      exercise: ex3
    }
  ]
}

#
# WORKOUT
#

wk1 =
  %Workout{
    user: tomo,
    name: "Chest Day",
    start_date: ~D[2023-03-21],
    notes: "I felt really good today",
    rounds: [rd1]
  }
  |> Repo.insert!()

wk2 =
  %Workout{
    user: nicole,
    name: "Fran",
    start_date: ~D[2023-03-23],
    notes: "This is a beast",
    rounds: [rd2]
  }
  |> Repo.insert!()

wk3 =
  %Workout{
    user: tomo,
    name: "Multiple Rounds",
    start_date: ~D[2023-03-22],
    notes: "Didn't fancy it",
    rounds: [rd1, rd2]
  }
  |> Repo.insert!()
