defmodule GenpagxWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use GenpagxWeb, :controller

  # This clause handles errors returned by Ecto's insert/update/delete.
  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(GenpagxWeb.ChangesetView)
    |> render("error.json", changeset: changeset)
  end

  def call(conn, {:error, _, %Ecto.Changeset{} = changeset, _}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(GenpagxWeb.ChangesetView)
    |> render("error.json", changeset: changeset)
  end

  def call(conn, {:error, _, reason, _}) do
    conn
    |> put_status(:bad_request)
    |> put_view(GenpagxWeb.ErrorView)
    |> render("error.json", reason: reason)
  end

  # This clause is an example of how to handle resources that cannot be found.
  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(GenpagxWeb.ErrorView)
    |> render(:"404")
  end

  def call(conn, {:error, reason}) do
    conn
    |> put_status(:bad_request)
    |> put_view(GenpagxWeb.ErrorView)
    |> render("error.json", reason: reason)
  end
end
