defmodule Satanut.Commands do
  use Alchemy.Cogs

  Cogs.def sardine do
    Cogs.say("Sardine")
  end

  Cogs.def test do
    Cogs.say("Test")
  end

  Cogs.def redemption do
    Cogs.say("Tu oses défier le jugement du grand Satanut ?")

    Cogs.member()
    |> IO.inspect()
    |> case do
      {:ok, member} ->
        case Enum.random([true, false]) do
          true -> sacrifice(message, member.user.id)
          false -> Cogs.say("Puisque je suis de bonne humeur, je t'épargne.")
        end
      _ ->
        nil
    end
  end

  Cogs.def sacrifice(user) do
    user_id = user |> String.replace(~r/[^\d]/, "")
    Cogs.say("test " <> user_id <> ".")
  end
end
