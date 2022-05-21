defmodule Satanut.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  alias Alchemy.Client

  def load_module do
    use Satanut.Commands
    use Satanut.Events
  end

  @impl true
  def start(_type, _args) do
    children = []

    Client.start(Application.get_env(:satanut, :token))
    load_module()

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Satanut.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
