defmodule GenpagxWeb.AddressView do
  use GenpagxWeb, :view
  alias GenpagxWeb.AddressView

  def render("index.json", %{addresses: addresses}) do
    %{data: render_many(addresses, AddressView, "address.json")}
  end

  def render("show.json", %{address: address}) do
    %{data: render_one(address, AddressView, "address.json")}
  end

  def render("address.json", %{address: address}) do
    %{
      street: address.street,
      number: address.number || "",
      complement: address.complement || "",
      neighborhood: address.neighborhood,
      city: address.city,
      state: address.state,
      postal_code: address.postal_code
    }
  end
end
