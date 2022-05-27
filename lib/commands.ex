defmodule Satanut.Commands do
  use Alchemy.Cogs
  alias Alchemy.Client

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
    stake_role_id = Application.get_env(:satanut, :stake_role_id)

    Cogs.guild_id()
    |> case do
      {:ok, guild_id} ->
        roles = Client.get_member(guild_id, user_id)
          |> case do
            {:ok, guild_member} -> guild_member.roles
            _ -> []
          end

        IO.inspect("Guild id : " <> guild_id)
        IO.inspect("User id : " <> user_id)

        Enum.map(roles, &Client.remove_role(guild_id, user_id, &1))
        Client.add_role(guild_id, user_id, stake_role_id)
        Cogs.say("Et hop! Tes droits humains ont disparus!")
        Process.sleep(40000)
        Client.remove_role(guild_id, user_id, stake_role_id)
        Enum.map(roles, &Client.add_role(guild_id, user_id, &1))
        Cogs.say("Abracadabra et te revoila!")

      _ -> nil
    end
  end
end
