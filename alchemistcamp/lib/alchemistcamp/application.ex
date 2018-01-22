defmodule Alchemistcamp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    start_webserver()

    # List all child processes to be supervised
    children = [
      # Starts a worker by calling: Alchemistcamp.Worker.start_link(arg)
      # {Alchemistcamp.Worker, arg},
    ]

    opts = [strategy: :one_for_one, name: Alchemistcamp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def start_webserver() do
    routes = [
      {"/", :cowboy_static, {:priv_file, :alchemistcamp, "static/index.html"}},
      {"/static/[...]", :cowboy_static, {:priv_dir, :alchemistcamp, "static"}},
      {:_, Owl.PageHandler, Alchemistcamp.Web.Router}
    ]

    dispatch = :cowboy_router.compile([{:_, routes}])

    opts = [port: 8080]
    env = [dispatch: dispatch]

    case :cowboy.start_http(:http, 100, opts, [env: env]) do
      {:ok, _pid} -> IO.puts("Cowboy is now running. Go to http://localhost:8080.")
      _ -> IO.puts("There was an error starting Cowboy webserver.")
    end
  end

end
