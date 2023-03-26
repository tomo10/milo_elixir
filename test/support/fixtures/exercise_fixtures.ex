defmodule Milo.ExerciseFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Milo.Exercise` context.
  """

  @doc """
  Generate a info.
  """
  def info_fixture(attrs \\ %{}) do
    {:ok, info} =
      attrs
      |> Enum.into(%{
        body_part: "some body_part",
        name: "some name"
      })
      |> Milo.Exercise.create_info()

    info
  end
end
