defmodule Suggestotron.Application do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    :ets.new(:session, [:named_table, :public, read_concurrency: true])

    # Define workers and child supervisors to be supervised
    children = [
      # Start the Ecto repository
      supervisor(Suggestotron.Repo, []),
      # Start the endpoint when the application starts
      supervisor(SuggestotronWeb.Endpoint, []),
      # Start your own worker by calling: Suggestotron.Worker.start_link(arg1, arg2, arg3)
      # worker(Suggestotron.Worker, [arg1, arg2, arg3]),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Suggestotron.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    SuggestotronWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
