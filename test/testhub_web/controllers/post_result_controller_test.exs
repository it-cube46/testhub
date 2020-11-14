defmodule TesthubWeb.PostResultControllerTest do
  use TesthubWeb.ConnCase

  alias Testhub.PostResults
  alias Testhub.PostResults.PostResult

  @create_attrs %{
    group: "some group",
    name: "some name",
    resultjson: "some resultjson"
  }
  @update_attrs %{
    group: "some updated group",
    name: "some updated name",
    resultjson: "some updated resultjson"
  }
  @invalid_attrs %{group: nil, name: nil, resultjson: nil}

  def fixture(:post_result) do
    {:ok, post_result} = PostResults.create_post_result(@create_attrs)
    post_result
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all results", %{conn: conn} do
      conn = get(conn, Routes.post_result_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create post_result" do
    test "renders post_result when data is valid", %{conn: conn} do
      conn = post(conn, Routes.post_result_path(conn, :create), post_result: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.post_result_path(conn, :show, id))

      assert %{
               "id" => id,
               "group" => "some group",
               "name" => "some name",
               "resultjson" => "some resultjson"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.post_result_path(conn, :create), post_result: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update post_result" do
    setup [:create_post_result]

    test "renders post_result when data is valid", %{conn: conn, post_result: %PostResult{id: id} = post_result} do
      conn = put(conn, Routes.post_result_path(conn, :update, post_result), post_result: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.post_result_path(conn, :show, id))

      assert %{
               "id" => id,
               "group" => "some updated group",
               "name" => "some updated name",
               "resultjson" => "some updated resultjson"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, post_result: post_result} do
      conn = put(conn, Routes.post_result_path(conn, :update, post_result), post_result: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete post_result" do
    setup [:create_post_result]

    test "deletes chosen post_result", %{conn: conn, post_result: post_result} do
      conn = delete(conn, Routes.post_result_path(conn, :delete, post_result))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.post_result_path(conn, :show, post_result))
      end
    end
  end

  defp create_post_result(_) do
    post_result = fixture(:post_result)
    %{post_result: post_result}
  end
end
