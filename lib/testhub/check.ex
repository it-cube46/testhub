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

def checkieds(ans) do
  ans |> Enum.map fn e -> e|>checkied end
end

def checkied(ied) do
  ied |> Map.to_list |> check_settings1 |> :lists.flatten
end

def check_settings1([]) do [] end
def check_settings1([{key,val} | rest]) do
  [check_settings2(key,val) | check_settings1(rest) ]
end

def check_settings2("IPAddress",ipaddr) do 
case :inet.parse_ipv4_address(:erlang.binary_to_list(ipaddr)) do
{:error, _} -> ["ip address incorrect"]
{:ok, ipv4} -> []
end
end

def check_settings2("IPMask",ipaddr) do 
case :inet.parse_ipv4_address(:erlang.binary_to_list(ipaddr)) do
{:error, _} -> ["ip mask incorrect"]
{:ok, ipv4} -> check_mask(:erlang.tuple_to_list(ipv4))
end
end

def check_mask0([]) do [] end
def check_mask0([0|rest]) do
  check_mask0(rest)
end
def check_mask0([_|rest]) do
  ["ip mask bad"]
end

def check_mask([]) do [] end

def check_mask([n|rest]) do
case n do
  255 -> check_mask(rest)
  254 -> check_mask0(rest)
  252 -> check_mask0(rest)
  248 -> check_mask0(rest)
  240 -> check_mask0(rest)
  224 -> check_mask0(rest)
  192 -> check_mask0(rest)
  128 -> check_mask0(rest)
  0 -> check_mask0(rest)
  _ -> 
  ["ip mask bad"]
end
end

def check_settings2("MACadress",mac) do 
try do
dmac=mac |> String.split(":") |> Enum.map(fn x -> {i,""}=Integer.parse(x,16); i end)
[1, 12, 205, 1, p, _] = dmac
true = (p==0 or p==1)
dmac |> inspect |> Logger.debug
[]
rescue MatchError -> ["mac error"] end
end

def check_settings2("VLANID",vlan) do 
try do
{i,""}=Integer.parse(vlan,10)
true = (i>=0 and i<4096)
[]
rescue MatchError -> ["vlan error"] end
end

def check_settings2("MinTime",v) do 
try do
{i,""}=Integer.parse(v)
true = (i==4)
[]
rescue MatchError -> ["MinTime error"] end
end

def check_settings2("MaxTime",v) do 
try do
{i,""}=Integer.parse(v)
true = (i==1000)
[]
rescue MatchError -> ["MaxTime error"] end
end


def check_settings2("APPID",v) do 
try do
{i,""}=Integer.parse(v,16)
true = (i>=0x8000 and i<0xc000)
[]
rescue MatchError -> ["appid error"] end
end

def check_settings2(_,_) do [] end

#def checkied_net(%{"IPAddress" => ipaddr, "IPMask" => mask, "MACadress"=>mac}) do
#case :inet.parse_ipv4_address(:erlang.binary_to_list(ipaddr)) do
#{:error, _} -> 
#{:ok, ipv4} ->
#{:ok, mask}=:inet.parse_ipv4_address(:erlang.binary_to_list(mask))
#ipv4 |> inspect |> Logger.info
#
#end

end
