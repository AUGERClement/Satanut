defmodule Satanut.Commands do
  use Alchemy.Cogs

  Cogs.def sardine do
    Cogs.say("Sardine")
  end

  Cogs.def test do
    Cogs.say("Test")
  end

  Cogs.def setroleid(role) do
    Cogs.say("Le rôle bûcher a été set à : " <> role <> ".")

  end
end
