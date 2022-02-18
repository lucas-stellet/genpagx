defmodule GenpagxWeb.WelcomeController do
  use GenpagxWeb, :controller

  def index(conn, _params) do
    conn
    |> put_status(:ok)
    |> json(%{"message" => "Welcome to Genpagx API!"})
  end
end
