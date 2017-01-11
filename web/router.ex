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
  end

  scope "/", Suggestotron do
    pipe_through :browser # Use the default browser stack

    get "/", VenueController, :index
    resources "/venues", VenueController
    resources "/categories", CategoryController, param: "name"
    resources "/users", UserController
  end

  scope "/" do
    addict :routes,
      register: "/"
  end

  # Other scopes may use custom stacks.
  # scope "/api", Suggestotron do
  #   pipe_through :api
  # end
end
