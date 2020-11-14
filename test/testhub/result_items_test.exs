defmodule Testhub.ResultItemsTest do
  use Testhub.DataCase

  alias Testhub.ResultItems

  describe "resultitems" do
    alias Testhub.ResultItems.ResultItem

    @valid_attrs %{responce: "some responce", score: 42, valid: 42}
    @update_attrs %{responce: "some updated responce", score: 43, valid: 43}
    @invalid_attrs %{responce: nil, score: nil, valid: nil}

    def result_item_fixture(attrs \\ %{}) do
      {:ok, result_item} =
        attrs
        |> Enum.into(@valid_attrs)
        |> ResultItems.create_result_item()

      result_item
    end

    test "list_resultitems/0 returns all resultitems" do
      result_item = result_item_fixture()
      assert ResultItems.list_resultitems() == [result_item]
    end

    test "get_result_item!/1 returns the result_item with given id" do
      result_item = result_item_fixture()
      assert ResultItems.get_result_item!(result_item.id) == result_item
    end

    test "create_result_item/1 with valid data creates a result_item" do
      assert {:ok, %ResultItem{} = result_item} = ResultItems.create_result_item(@valid_attrs)
      assert result_item.responce == "some responce"
      assert result_item.score == 42
      assert result_item.valid == 42
    end

    test "create_result_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ResultItems.create_result_item(@invalid_attrs)
    end

    test "update_result_item/2 with valid data updates the result_item" do
      result_item = result_item_fixture()
      assert {:ok, %ResultItem{} = result_item} = ResultItems.update_result_item(result_item, @update_attrs)
      assert result_item.responce == "some updated responce"
      assert result_item.score == 43
      assert result_item.valid == 43
    end

    test "update_result_item/2 with invalid data returns error changeset" do
      result_item = result_item_fixture()
      assert {:error, %Ecto.Changeset{}} = ResultItems.update_result_item(result_item, @invalid_attrs)
      assert result_item == ResultItems.get_result_item!(result_item.id)
    end

    test "delete_result_item/1 deletes the result_item" do
      result_item = result_item_fixture()
      assert {:ok, %ResultItem{}} = ResultItems.delete_result_item(result_item)
      assert_raise Ecto.NoResultsError, fn -> ResultItems.get_result_item!(result_item.id) end
    end

    test "change_result_item/1 returns a result_item changeset" do
      result_item = result_item_fixture()
      assert %Ecto.Changeset{} = ResultItems.change_result_item(result_item)
    end
  end
end
