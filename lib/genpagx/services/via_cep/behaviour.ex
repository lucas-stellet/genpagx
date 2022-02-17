defmodule Genpagx.Services.ViaCEP.Behaviour do
  @moduledoc """
  Behaviour that defins the functions and return expected for ViaCep Service API.
  """
  @type cep() :: binary()
  @type json_response() :: map()
  @type error_message() :: String.t() | map()

  @doc """
  Search a CEP.
  """
  @callback validate_cep(cep) ::
              {:ok, json_response()} | {:error, error_message()} | {:error, :not_found}
end
