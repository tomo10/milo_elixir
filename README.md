# Milo

Milo was a renowned athlete hailing from Croton in ancient Greece. Legend has it Milo trained by carrying a calf daily from its birth until it became a full-sized ox. This idea of progressive overload remains to this day.

The app will allow users to create workouts, setting rounds, sets, reps, and weight. Users will also be able to share workouts with other users, allowing a community to share and inspire one another. Think strava for weight / resistance training.

Other functionality and features are in the pipeline but not listed above.

To start the server:

- Run `mix setup` to install and setup dependencies
- Run `docker-compose up` to start postgres containerised database
- Seed the sample data running `mix exto.reset`
- Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Queries and mutations can be run from `http://localhost:4000/gql/GraphiQL`
