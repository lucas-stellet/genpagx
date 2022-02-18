defmodule GenpagxWeb.UserView do
  use GenpagxWeb, :view
  alias GenpagxWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      name: user.name,
      cpf: user.cpf,
      address: render_one(user.address, GenpagxWeb.AddressView, "address.json")
    }
  end
end
