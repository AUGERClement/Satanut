defmodule Satanut.Commands do
  use Alchemy.Cogs

  Cogs.def poisson do
    Cogs.say("Sardine")
  end

  Cogs.def test do
    Cogs.say("Test")
  end
end
