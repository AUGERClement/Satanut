defmodule Satanut.Events do
  use Alchemy.Events
  alias Alchemy.Embed
  use Alchemy.Cogs

  Events.on_message(:define_reply)

  def reply(:sardine, message) do
    sardine_embed = Embed.from_assets("sardine", title: "Sardina pilchardus")
    Cogs.say("", embed: sardine_embed)
  end

  def reply(:communist, message) do
    gifs = [
      "https://tenor.com/8pZh.gif",
      "https://tenor.com/3JsX.gif",
      "https://tenor.com/bG0m6.gif",
      "https://tenor.com/bAqJF.gif",
      "https://tenor.com/0PK5.gif",
      "https://tenor.com/beJMZ.gif"
    ]

    Cogs.say(Enum.random(gifs))
  end

  def reply(:el_psy_congroo, message) do
    gifs = [
      "https://tenor.com/view/okabe-rintaro-gif-18515625",
    ]

    Cogs.say(Enum.random(gifs))
  end

  def reply(keyword, message) do
    embed = Embed.from_assets(Atom.to_string(keyword), title: "Sardina pilchardus")
    Cogs.say("", embed: embed)
  end

  def define_reply(message) do
    is_in = fn (str, keyword) -> str =~ keyword end
    any_in = fn (str, keywords) -> true in Enum.map(keywords, &is_in.(str, &1)) end
    downcased = String.downcase(message.content)

    sardine_matches = ["sardine", "poisson", "mer", "vitamines", "thon", "maquereau"]
    communist_matches = ["rouge", "notre", "nous", "nos", "ensemble", "communisme", "marx", "patrie"]
    el_psy_congroo_matches = ["chaos", "phonewave", "micro-onde"]

    sardine = any_in.(downcased, sardine_matches)
    communist = any_in.(downcased, communist_matches)
    el_psy_congroo = any_in.(downcased, el_psy_congroo_matches)

    matches = [
      {sardine, fn -> reply(:sardine, message) end},
      {communist, fn -> reply(:communist, message) end},
      {el_psy_congroo, fn -> reply(:el_psy_congroo, message) end}
    ]

    Enum.map(matches, fn {atom, keywords} -> if any_in.(downcased, keywords) do atom end end)
    |> IO.inspect
    |> Enum.find(&Function.identity(&1)) #First non nil val of list or nil
    |> IO.inspect
    |> case do
        nil -> nil
        match -> reply(match, message)
      end
  end

end
