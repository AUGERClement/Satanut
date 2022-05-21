defmodule Satanut.Events do
  use Alchemy.Events
  alias Alchemy.Client
  use Alchemy.Cogs

  Events.on_message(:define_reply)

  def reply("sardine") do
    Client.send_message("")
  end


  def define_reply(message) do
    gen_matcher = fn (str, keyword) -> str =~ keyword end
    x = gen_matcher.(String.downcase(message.content), "sardine")

    case x and !message.author.bot do
      true -> Cogs.say("mmmmmmmh sardine mhhhm")
      _ -> nil
    end

    # contain Sardine => reply("sardine")
    # contain a communist_keyword => reply("rouge")
  end
end
