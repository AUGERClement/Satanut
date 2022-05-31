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
    user_tag = "<@" <> user_id <> ">"

    answer_list = [
      "Et hop! #{user_tag} tes droits humains ont disparus !",
      "Tiens, félicitations #{user_tag}, un ticket pour le bucher express, embarquement immédiat ...",
      "Pas de chance, #{user_tag}, tu retournes au bûcher."
    ]

    Cogs.guild_id()
    |> case do
      {:ok, guild_id} ->
        roles =
          Client.get_member(guild_id, user_id)
          |> case do
            {:ok, guild_member} -> guild_member.roles
            _ -> []
          end

        Enum.map(roles, &Client.remove_role(guild_id, user_id, &1))
        Client.add_role(guild_id, user_id, stake_role_id)
        Cogs.say(Enum.random(answer_list))
        Process.sleep(10000)
        Client.remove_role(guild_id, user_id, stake_role_id)
        Enum.map(roles, &Client.add_role(guild_id, user_id, &1))

      _ ->
        nil
    end
  end

  Cogs.def caprice() do
    random_count = Enum.random(5..15)
    Cogs.say("Satanut va purifier le discord.")

    Cogs.guild_id()
    |> case do
      {:ok, guild_id} ->
        Client.get_member_list(guild_id, limit: 200)
        |> case do
          {:ok, members} ->
            members
            |> Enum.filter(fn member -> !member.user.bot end)
            |> Enum.shuffle()
            |> Enum.take(random_count)
            |> Enum.map(fn member ->
              sacrifice(message, member.user.id)
            end)

          _ ->
            nil
        end

      _ ->
        nil
    end

    Cogs.say("Le discord est désormais pur.")
  end
end
