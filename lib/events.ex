defmodule Satanut.Events do
  use Alchemy.Events
  use Alchemy.Client

  Events.on_message(:define_reply)

  def reply("sardine") do
    Client.send_message("")
  end

  def define_reply(message) do
    IO.inspect(message.content)

    # contain Sardine => reply("sardine")
    # contain a communist_keyword => reply("rouge")
  end
end
