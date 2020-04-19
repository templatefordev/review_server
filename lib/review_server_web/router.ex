defmodule ReviewServerWeb.Router do
  use ReviewServerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ReviewServerWeb do
    pipe_through :api

    resources "/reviews", ReviewController, except: [:new, :edit]
  end
end
