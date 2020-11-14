defmodule TesthubWeb.ResultItemController do
  use TesthubWeb, :controller

  alias Testhub.ResultItems
  alias Testhub.ResultItems.ResultItem

  def index(conn, _params) do
    resultitems = ResultItems.list_resultitems()
    render(conn, "index.html", resultitems: resultitems)
  end

  def new(conn, _params) do
    changeset = ResultItems.change_result_item(%ResultItem{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"result_item" => result_item_params}) do
    case ResultItems.create_result_item(result_item_params) do
      {:ok, result_item} ->
        conn
        |> put_flash(:info, "Result item created successfully.")
        |> redirect(to: Routes.result_item_path(conn, :show, result_item))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    result_item = ResultItems.get_result_item!(id)
    render(conn, "show.html", result_item: result_item)
  end

  def edit(conn, %{"id" => id}) do
    result_item = ResultItems.get_result_item!(id)
    changeset = ResultItems.change_result_item(result_item)
    render(conn, "edit.html", result_item: result_item, changeset: changeset)
  end

  def update(conn, %{"id" => id, "result_item" => result_item_params}) do
    result_item = ResultItems.get_result_item!(id)

    case ResultItems.update_result_item(result_item, result_item_params) do
      {:ok, result_item} ->
        conn
        |> put_flash(:info, "Result item updated successfully.")
        |> redirect(to: Routes.result_item_path(conn, :show, result_item))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", result_item: result_item, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    result_item = ResultItems.get_result_item!(id)
    {:ok, _result_item} = ResultItems.delete_result_item(result_item)

    conn
    |> put_flash(:info, "Result item deleted successfully.")
    |> redirect(to: Routes.result_item_path(conn, :index))
  end
end
