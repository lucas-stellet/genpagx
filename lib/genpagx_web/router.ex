defmodule GenpagxWeb.Router do
  use GenpagxWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", GenpagxWeb do
    pipe_through :api

    resources "/accounts", UserController, except: [:new, :edit]
  end
end
