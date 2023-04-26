defmodule Milo.SchemaTest do
  use MiloWeb.ConnCase
  # https://hexdocs.pm/absinthe/testing.html

  @exercise_query """
  query {
    exercise(id: $id) {
      name
    }
  }
  """

  test "query: exercise", %{conn: conn} do
    conn =
      post(conn, "/api", %{
        "query" => @exercise_query,
        "variables" => %{id: 1}
      })

    assert json_response(conn, 200) == %{
             "data" => %{"exercise" => %{"bodyPart" => "Chest", "name" => "Bench Press"}}
           }
  end
end
