defmodule Satanut.Events do
  use Alchemy.Events
  alias Alchemy.Client
  alias Alchemy.Embed
  use Alchemy.Cogs

  Events.on_message(:define_reply)

  def reply("sardine", message) do
    my_embed = %Embed{}
            |> Embed.title("Sardina pilchardus")
            |> Embed.color(0xff9300)
            |> Embed.description("PlaceHolder")
    Cogs.say("", embed: my_embed)
  end

  def reply("communist", message) do
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


  def callback({value, call}) do
    case value do
      true -> call.()
      _ -> nil
    end
  end

  def define_reply(message) do
    gen_matcher = fn (str, keyword) -> str =~ keyword end
    gen_matchers = fn (str, keywords) -> true in Enum.map(keywords, &gen_matcher.(str, &1)) end

    communist_matches = ["rouge", "notre", "nous", "nos", "ensembles", "communisme", "marx", "patrie"]

    sardine = gen_matcher.(String.downcase(message.content), "sardine")
    communist = gen_matchers.(String.downcase(message.content), communist_matches)

    eval = [
      {sardine, fn -> reply("sardine", message) end},
      {communist, fn -> reply("communist", message) end}
    ]

    case message.author.bot do
      false -> Enum.find(eval, &callback(&1))
      _ -> nil
    end

    # contain Sardine => reply("sardine")
    # contain a communist_keyword => reply("rouge")
  end

  # Hard coder une liste de gif communists et en envoyer un au pif à chaque Comu_keyword
end
