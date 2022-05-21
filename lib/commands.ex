defmodule Satanut.Commands do
  use Alchemy.Cogs
  alias Alchemy.Embed

  Cogs.def sardine do
    Cogs.say("Sardine")
  end

  Cogs.def test do
    Cogs.say("Test")
  end
end
