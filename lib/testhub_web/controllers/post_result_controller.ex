defmodule TesthubWeb.PostResultController do
  use TesthubWeb, :controller
  require Logger

  alias Testhub.PostResults
  alias Testhub.PostResults.PostResult

  action_fallback TesthubWeb.FallbackController

  def index(conn, _params) do
    conn |> put_status(405) |> 
      render("error.json",text: "Method Not Allowed")
  end

  def create(conn, data) do
    #data |> inspect() |> Logger.info
    case data do
      %{ "username"=> user, "group"=> group, "test"=> testid,
        "kind" => "iedlab", "answer"=>ans } ->
        Logger.info(inspect(ans))
        problems=Testhub.Check.checkieds(ans) 
        problems |> inspect |> Logger.info
        render(conn, "error.json", text: problems)

      %{ "username"=> user, "group"=> group, "test"=> testid, "answers"=>ans } ->
        testinfo=Testhub.Repo.get(Testhub.Tests.Test,testid)
        testinfo |> inspect() |> Logger.info
        json=Jason.encode!(ans)
        {score, res}=Testhub.Check.verify(testinfo.filename, ans)

        newObj=%Testhub.Results.Result{
                name: user,
                group: group,
                resultjson: json,
                response: Jason.encode!(res),
                score: score,
                test: testinfo }
        newObj |> Logger.info
        created=Testhub.Repo.insert(newObj)
        created |> inspect() |> Logger.info
        render(conn, "testresult.json", score: score, result: res)
      _ ->
        render(conn, "error.json", text: "bad parameters")
    end
  end

end
