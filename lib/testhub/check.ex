defmodule Testhub.Check do
  require Logger

def verify(file, resultset) do
  {:ok, filedata} = File.read("./priv/static" <> file)
  {:ok, json} = Jason.decode(filedata)
  json |> inspect() |> Logger.info
  {score, n, res}=List.foldl(json, {0, 0, []}, 
      fn(%{"id" => id, "CorrectAnswer" => correct}, {score, c, acc}) -> 
        answered=Map.get(resultset,Integer.to_string(id))
        if answered == correct do
          {score+1, c+1,[%{:id=>id, :answered=>answered, :valid=>1}|acc]}
        else
          {score, c+1, [%{:id=>id, :answered=>answered, :valid=>0}|acc]}
        end
      end)
  res |> inspect() |> Logger.info
  resultset |> inspect() |> Logger.info
  {round((score * 1000) / n), res}
end

def details(result) do
  result |> inspect() |> Logger.debug()
  {:ok, filedata} = File.read("./priv/static" <> result.test.filename)
  {:ok, json} = Jason.decode(filedata)
  {:ok, resp} = Jason.decode(result.response)

  ua=List.foldl(resp, %{}, fn(%{"id" => id, "answered" => ans}, acc) ->
      Map.put(acc, id, ans)
      end)

  Enum.map(json, 
      fn(%{"id" => id, "TextQuestion" => tq}=e) -> 
      %{  :id => id, 
          :tq => tq,
          :items => Map.to_list(takeAns(e,1,%{})),
          :ans => Map.get(ua, id),
          :right => Map.get(e, "CorrectAnswer") }
      end)
end

def takeAns(ta, n, acc) do
  case Map.get(ta, "TextAnswer" <> Integer.to_string(n)) do
    nil -> acc
    any -> takeAns(ta,n+1,Map.put(acc, n, any))
  end
end

end
