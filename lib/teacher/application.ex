defmodule Teacher.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = get_children()

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Teacher.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp get_children do
    Enum.map([:btc, :eth, :ltc], fn(coin) ->
      Supervisor.child_spec({Teacher.CoinDataWorker, %{id: coin}}, id: coin)
    end)
  end

end
