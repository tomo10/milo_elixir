defmodule Milo.ExerciseTest do
  use Milo.DataCase

  alias Milo.Exercise

  describe "information" do
    alias Milo.Exercise.Info

    import Milo.ExerciseFixtures

    @invalid_attrs %{body_part: nil, name: nil}

    test "list_information/0 returns all information" do
      info = info_fixture()
      assert Exercise.list_information() == [info]
    end

    test "get_info!/1 returns the info with given id" do
      info = info_fixture()
      assert Exercise.get_info!(info.id) == info
    end

    test "create_info/1 with valid data creates a info" do
      valid_attrs = %{body_part: "some body_part", name: "some name"}

      assert {:ok, %Info{} = info} = Exercise.create_info(valid_attrs)
      assert info.body_part == "some body_part"
      assert info.name == "some name"
    end

    test "create_info/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Exercise.create_info(@invalid_attrs)
    end

    test "update_info/2 with valid data updates the info" do
      info = info_fixture()
      update_attrs = %{body_part: "some updated body_part", name: "some updated name"}

      assert {:ok, %Info{} = info} = Exercise.update_info(info, update_attrs)
      assert info.body_part == "some updated body_part"
      assert info.name == "some updated name"
    end

    test "update_info/2 with invalid data returns error changeset" do
      info = info_fixture()
      assert {:error, %Ecto.Changeset{}} = Exercise.update_info(info, @invalid_attrs)
      assert info == Exercise.get_info!(info.id)
    end

    test "delete_info/1 deletes the info" do
      info = info_fixture()
      assert {:ok, %Info{}} = Exercise.delete_info(info)
      assert_raise Ecto.NoResultsError, fn -> Exercise.get_info!(info.id) end
    end

    test "change_info/1 returns a info changeset" do
      info = info_fixture()
      assert %Ecto.Changeset{} = Exercise.change_info(info)
    end
  end
end
