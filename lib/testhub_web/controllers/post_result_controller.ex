defmodule TesthubWeb.PostResultController do
  use TesthubWeb, :controller
  require Logger

  alias Testhub.PostResults
  alias Testhub.PostResults.PostResult

  action_fallback TesthubWeb.FallbackController

  def index(conn, _params) do
    results = PostResults.list_results()
    render(conn, "index.json", results: results)
  end

#  def create(conn, %{"post_result" => post_result_params}) do
#    with {:ok, %PostResult{} = post_result} <- PostResults.create_post_result(post_result_params) do
#      Logger.info("post")
#      conn
#      |> put_status(:created)
#      |> put_resp_header("location", Routes.post_result_path(conn, :show, post_result))
#      |> render("show.json", post_result: post_result)
#    end
#  end

  def create(conn, data) do
    data |> inspect() |> Logger.info
    case data do
      %{ "username"=> user, "group"=> group, "test"=> testid, "answers"=>ans } ->
        testinfo=Testhub.Repo.get(Testhub.Tests.Test,testid)
        testinfo |> inspect() |> Logger.info
        json=Jason.encode!(ans)
        json |> Logger.info
        Testhub.Repo.insert(%Testhub.Results.Result{
                name: user,
                group: group,
                resultjson: json,
                test: testid })
        render(conn, "test.json", a: 1)
      _ ->
        render(conn, "error.json", text: "bad parameters")
    end
  end



  def show(conn, %{"id" => id}) do
    post_result = PostResults.get_post_result!(id)
    render(conn, "show.json", post_result: post_result)
  end

  def update(conn, %{"id" => id, "post_result" => post_result_params}) do
    post_result = PostResults.get_post_result!(id)

    with {:ok, %PostResult{} = post_result} <- PostResults.update_post_result(post_result, post_result_params) do
      render(conn, "show.json", post_result: post_result)
    end
  end

  def delete(conn, %{"id" => id}) do
    post_result = PostResults.get_post_result!(id)

    with {:ok, %PostResult{}} <- PostResults.delete_post_result(post_result) do
      send_resp(conn, :no_content, "")
    end
  end
end
