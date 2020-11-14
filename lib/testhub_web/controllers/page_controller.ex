defmodule TesthubWeb.PageController do
  use TesthubWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
