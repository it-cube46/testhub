defmodule TesthubWeb.TestApiController do
  use TesthubWeb, :controller

  require Logger
  alias Testhub.TestsApi
  alias Testhub.TestsApi.TestApi

  action_fallback TesthubWeb.FallbackController

  def index(conn, _params) do
  host_with_port = Atom.to_string(conn.scheme) <> "://" <>
  conn.host <> ":" <> Integer.to_string(conn.port)
    tests = TestsApi.list_tests()
    render(conn, "index.json", tests: tests, host: host_with_port )
  end

end
