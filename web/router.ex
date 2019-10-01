defmodule Suggestotron.Router do
  use Suggestotron.Web, :router
  use Addict.RoutesHelper

  pipeline :browser do
    plug :accepts, ~w(html json)
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    if Mix.env == :prod do
      plug LessVerifiesAlexa.Plug, application_id:
        System.get_env("ALEXA_APPLICATION_ID")
    end
  end

  scope "/", Suggestotron do
    pipe_through :browser # Use the default browser stack

    get "/", VenueController, :index
    resources "/venues", VenueController
    resources "/categories", CategoryController, param: "name"
    resources "/users", UserController
  end

  scope "/command", Suggestotron do
    pipe_through :api
    post "/", AlexaController, :command
  end

  scope "/" do
    addict :routes,
      register: "/"
  end

end
