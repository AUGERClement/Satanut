defmodule Satanut.Events do
  use Alchemy.Events
  alias Alchemy.Client
  use Alchemy.Cogs

  Events.on_message(:define_reply)

  def reply("sardine", message) do
    Cogs.say("mmmmmmmh sardine mhhhm")
  end

  def reply("communist", message) do
    Cogs.say("https://tenor.com/view/ours-communism-bugs-bunny-communist-gif-24069854")
  end


  def callback({value, call}) do
    case value do
      true -> call.()
      _ -> nil
    end
  end

  def define_reply(message) do
    gen_matcher = fn (str, keyword) -> str =~ keyword end
    sardine = gen_matcher.(String.downcase(message.content), "sardine")
    communist = gen_matcher.(String.downcase(message.content), "rouge")
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
