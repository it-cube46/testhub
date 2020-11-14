defmodule Testhub.TestsApiTest do
  use Testhub.DataCase

  alias Testhub.TestsApi

  describe "tests" do
    alias Testhub.TestsApi.TestApi

    @valid_attrs %{filename: "some filename", name: "some name", title: "some title"}
    @update_attrs %{filename: "some updated filename", name: "some updated name", title: "some updated title"}
    @invalid_attrs %{filename: nil, name: nil, title: nil}

    def test_api_fixture(attrs \\ %{}) do
      {:ok, test_api} =
        attrs
        |> Enum.into(@valid_attrs)
        |> TestsApi.create_test_api()

      test_api
    end

    test "list_tests/0 returns all tests" do
      test_api = test_api_fixture()
      assert TestsApi.list_tests() == [test_api]
    end

    test "get_test_api!/1 returns the test_api with given id" do
      test_api = test_api_fixture()
      assert TestsApi.get_test_api!(test_api.id) == test_api
    end

    test "create_test_api/1 with valid data creates a test_api" do
      assert {:ok, %TestApi{} = test_api} = TestsApi.create_test_api(@valid_attrs)
      assert test_api.filename == "some filename"
      assert test_api.name == "some name"
      assert test_api.title == "some title"
    end

    test "create_test_api/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TestsApi.create_test_api(@invalid_attrs)
    end

    test "update_test_api/2 with valid data updates the test_api" do
      test_api = test_api_fixture()
      assert {:ok, %TestApi{} = test_api} = TestsApi.update_test_api(test_api, @update_attrs)
      assert test_api.filename == "some updated filename"
      assert test_api.name == "some updated name"
      assert test_api.title == "some updated title"
    end

    test "update_test_api/2 with invalid data returns error changeset" do
      test_api = test_api_fixture()
      assert {:error, %Ecto.Changeset{}} = TestsApi.update_test_api(test_api, @invalid_attrs)
      assert test_api == TestsApi.get_test_api!(test_api.id)
    end

    test "delete_test_api/1 deletes the test_api" do
      test_api = test_api_fixture()
      assert {:ok, %TestApi{}} = TestsApi.delete_test_api(test_api)
      assert_raise Ecto.NoResultsError, fn -> TestsApi.get_test_api!(test_api.id) end
    end

    test "change_test_api/1 returns a test_api changeset" do
      test_api = test_api_fixture()
      assert %Ecto.Changeset{} = TestsApi.change_test_api(test_api)
    end
  end
end
