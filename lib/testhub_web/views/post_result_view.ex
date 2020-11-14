defmodule TesthubWeb.PostResultView do
  use TesthubWeb, :view
  alias TesthubWeb.PostResultView

  def render("index.json", %{results: results}) do
    %{data: render_many(results, PostResultView, "post_result.json")}
  end

  def render("show.json", %{post_result: post_result}) do
    %{data: render_one(post_result, PostResultView, "post_result.json")}
  end

  def render("testresult.json", %{score: score, result: res}) do
    %{score: score, result: res}
  end

  def render("error.json", %{text: error_text}) do
    %{error: error_text}
  end

  def render("post_result.json", %{post_result: post_result}) do
    %{id: post_result.id,
      name: post_result.name,
      group: post_result.group,
      resultjson: post_result.resultjson}
  end
end
