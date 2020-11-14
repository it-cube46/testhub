defmodule TesthubWeb.TestApiController do
  use TesthubWeb, :controller

  require Logger
  alias Testhub.TestsApi
  alias Testhub.TestsApi.TestApi

  action_fallback TesthubWeb.FallbackController

  def index(conn, _params) do
  #Testhub.Router.Helpers.url(conn) |> inspect() |> Logger.info
  host_with_port = Atom.to_string(conn.scheme) <> "://" <>
  conn.host <> ":" <> Integer.to_string(conn.port)
    tests = TestsApi.list_tests()
    render(conn, "index.json", tests: tests, host: host_with_port )
  end

  def create(conn, %{"test_api" => test_api_params}) do
    with {:ok, %TestApi{} = test_api} <- TestsApi.create_test_api(test_api_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.test_api_path(conn, :show, test_api))
      |> render("show.json", test_api: test_api)
    end
  end

  def show(conn, %{"id" => id}) do
    test_api = TestsApi.get_test_api!(id)
    render(conn, "show.json", test_api: test_api)
  end

  def update(conn, %{"id" => id, "test_api" => test_api_params}) do
    test_api = TestsApi.get_test_api!(id)

    with {:ok, %TestApi{} = test_api} <- TestsApi.update_test_api(test_api, test_api_params) do
      render(conn, "show.json", test_api: test_api)
    end
  end

  def delete(conn, %{"id" => id}) do
    test_api = TestsApi.get_test_api!(id)

    with {:ok, %TestApi{}} <- TestsApi.delete_test_api(test_api) do
      send_resp(conn, :no_content, "")
    end
  end
end
