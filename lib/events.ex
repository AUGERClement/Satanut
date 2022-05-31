defmodule Satanut.Events do
  use Alchemy.Events
  alias Alchemy.Embed
  use Alchemy.Cogs

  Events.on_message(:define_reply)

  def reply(keyword, message, gifs, opts) do
    case opts do
      [] -> nil
      options -> Cogs.say("", embed: Embed.from_assets(Atom.to_string(keyword), options))
    end
    case gifs do
      [] -> nil
      list -> Cogs.say(Enum.random(list))
    end
  end

  def define_reply(message) do
    is_in = fn (str, keyword) -> str =~ keyword end
    any_in = fn (str, keywords) -> true in Enum.map(keywords, &is_in.(str, &1)) end
    downcased = String.downcase(message.content)

    Enum.map(Application.get_env(:satanut, :matches), fn {_atom, keywords, _gifs, _opts}=tuple -> if any_in.(downcased, keywords) do tuple end end)
    |> IO.inspect
    |> Enum.find(&Function.identity(&1)) #First non nil val of list or nil
    |> IO.inspect
    |> case do
        nil -> nil
        {atom, _keywords, gifs, opts} -> reply(atom, message, gifs, opts)
      end
  end

end
