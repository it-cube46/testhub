defmodule TesthubWeb.ResultItemControllerTest do
  use TesthubWeb.ConnCase

  alias Testhub.ResultItems

  @create_attrs %{responce: "some responce", score: 42, valid: 42}
  @update_attrs %{responce: "some updated responce", score: 43, valid: 43}
  @invalid_attrs %{responce: nil, score: nil, valid: nil}

  def fixture(:result_item) do
    {:ok, result_item} = ResultItems.create_result_item(@create_attrs)
    result_item
  end

  describe "index" do
    test "lists all resultitems", %{conn: conn} do
      conn = get(conn, Routes.result_item_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Resultitems"
    end
  end

  describe "new result_item" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.result_item_path(conn, :new))
      assert html_response(conn, 200) =~ "New Result item"
    end
  end

  describe "create result_item" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.result_item_path(conn, :create), result_item: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.result_item_path(conn, :show, id)

      conn = get(conn, Routes.result_item_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Result item"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.result_item_path(conn, :create), result_item: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Result item"
    end
  end

  describe "edit result_item" do
    setup [:create_result_item]

    test "renders form for editing chosen result_item", %{conn: conn, result_item: result_item} do
      conn = get(conn, Routes.result_item_path(conn, :edit, result_item))
      assert html_response(conn, 200) =~ "Edit Result item"
    end
  end

  describe "update result_item" do
    setup [:create_result_item]

    test "redirects when data is valid", %{conn: conn, result_item: result_item} do
      conn = put(conn, Routes.result_item_path(conn, :update, result_item), result_item: @update_attrs)
      assert redirected_to(conn) == Routes.result_item_path(conn, :show, result_item)

      conn = get(conn, Routes.result_item_path(conn, :show, result_item))
      assert html_response(conn, 200) =~ "some updated responce"
    end

    test "renders errors when data is invalid", %{conn: conn, result_item: result_item} do
      conn = put(conn, Routes.result_item_path(conn, :update, result_item), result_item: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Result item"
    end
  end

  describe "delete result_item" do
    setup [:create_result_item]

    test "deletes chosen result_item", %{conn: conn, result_item: result_item} do
      conn = delete(conn, Routes.result_item_path(conn, :delete, result_item))
      assert redirected_to(conn) == Routes.result_item_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.result_item_path(conn, :show, result_item))
      end
    end
  end

  defp create_result_item(_) do
    result_item = fixture(:result_item)
    %{result_item: result_item}
  end
end
