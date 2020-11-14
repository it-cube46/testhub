defmodule Testhub.PostResultsTest do
  use Testhub.DataCase

  alias Testhub.PostResults

  describe "results" do
    alias Testhub.PostResults.Result

    @valid_attrs %{group: "some group", name: "some name", resultjson: "some resultjson"}
    @update_attrs %{group: "some updated group", name: "some updated name", resultjson: "some updated resultjson"}
    @invalid_attrs %{group: nil, name: nil, resultjson: nil}

    def result_fixture(attrs \\ %{}) do
      {:ok, result} =
        attrs
        |> Enum.into(@valid_attrs)
        |> PostResults.create_result()

      result
    end

    test "list_results/0 returns all results" do
      result = result_fixture()
      assert PostResults.list_results() == [result]
    end

    test "get_result!/1 returns the result with given id" do
      result = result_fixture()
      assert PostResults.get_result!(result.id) == result
    end

    test "create_result/1 with valid data creates a result" do
      assert {:ok, %Result{} = result} = PostResults.create_result(@valid_attrs)
      assert result.group == "some group"
      assert result.name == "some name"
      assert result.resultjson == "some resultjson"
    end

    test "create_result/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PostResults.create_result(@invalid_attrs)
    end

    test "update_result/2 with valid data updates the result" do
      result = result_fixture()
      assert {:ok, %Result{} = result} = PostResults.update_result(result, @update_attrs)
      assert result.group == "some updated group"
      assert result.name == "some updated name"
      assert result.resultjson == "some updated resultjson"
    end

    test "update_result/2 with invalid data returns error changeset" do
      result = result_fixture()
      assert {:error, %Ecto.Changeset{}} = PostResults.update_result(result, @invalid_attrs)
      assert result == PostResults.get_result!(result.id)
    end

    test "delete_result/1 deletes the result" do
      result = result_fixture()
      assert {:ok, %Result{}} = PostResults.delete_result(result)
      assert_raise Ecto.NoResultsError, fn -> PostResults.get_result!(result.id) end
    end

    test "change_result/1 returns a result changeset" do
      result = result_fixture()
      assert %Ecto.Changeset{} = PostResults.change_result(result)
    end
  end

  describe "results" do
    alias Testhub.PostResults.PostResult

    @valid_attrs %{group: "some group", name: "some name", resultjson: "some resultjson"}
    @update_attrs %{group: "some updated group", name: "some updated name", resultjson: "some updated resultjson"}
    @invalid_attrs %{group: nil, name: nil, resultjson: nil}

    def post_result_fixture(attrs \\ %{}) do
      {:ok, post_result} =
        attrs
        |> Enum.into(@valid_attrs)
        |> PostResults.create_post_result()

      post_result
    end

    test "list_results/0 returns all results" do
      post_result = post_result_fixture()
      assert PostResults.list_results() == [post_result]
    end

    test "get_post_result!/1 returns the post_result with given id" do
      post_result = post_result_fixture()
      assert PostResults.get_post_result!(post_result.id) == post_result
    end

    test "create_post_result/1 with valid data creates a post_result" do
      assert {:ok, %PostResult{} = post_result} = PostResults.create_post_result(@valid_attrs)
      assert post_result.group == "some group"
      assert post_result.name == "some name"
      assert post_result.resultjson == "some resultjson"
    end

    test "create_post_result/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PostResults.create_post_result(@invalid_attrs)
    end

    test "update_post_result/2 with valid data updates the post_result" do
      post_result = post_result_fixture()
      assert {:ok, %PostResult{} = post_result} = PostResults.update_post_result(post_result, @update_attrs)
      assert post_result.group == "some updated group"
      assert post_result.name == "some updated name"
      assert post_result.resultjson == "some updated resultjson"
    end

    test "update_post_result/2 with invalid data returns error changeset" do
      post_result = post_result_fixture()
      assert {:error, %Ecto.Changeset{}} = PostResults.update_post_result(post_result, @invalid_attrs)
      assert post_result == PostResults.get_post_result!(post_result.id)
    end

    test "delete_post_result/1 deletes the post_result" do
      post_result = post_result_fixture()
      assert {:ok, %PostResult{}} = PostResults.delete_post_result(post_result)
      assert_raise Ecto.NoResultsError, fn -> PostResults.get_post_result!(post_result.id) end
    end

    test "change_post_result/1 returns a post_result changeset" do
      post_result = post_result_fixture()
      assert %Ecto.Changeset{} = PostResults.change_post_result(post_result)
    end
  end
end
