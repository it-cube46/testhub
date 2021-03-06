defmodule TesthubWeb.TestApiView do
  use TesthubWeb, :view
  alias TesthubWeb.TestApiView

  def render("index.json", %{tests: tests, host: host}) do
    %{data: #render_many(tests, TestApiView, "test_api.json"), host: host}
      Enum.map(tests, fn test ->
        render(TestApiView, "test_api.json", test_api: test, host: host)
      end)
      }
  end

  def render("show.json", %{test_api: test_api}) do
    %{data: render_one(test_api, TestApiView, "test_api.json")}
  end

  def render("test_api.json", %{test_api: test_api, host: host}) do
    %{id: test_api.id,
      name: test_api.name,
      title: test_api.title,
      filename: host <> test_api.filename
      }
  end
end
