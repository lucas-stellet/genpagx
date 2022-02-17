defmodule Genpagx.Services.ViaCEP.Mock do
  @moduledoc """
  Service Mock for ViaCEP
  """
  @behaviour Genpagx.Services.ViaCEP.Behaviour

  @impl true

  require Logger

  def validate_cep(cep) do
    data = via_cep_api_response()

    {:ok, data_decoded} = Jason.decode(data, keys: :atoms)

    case Enum.filter(data_decoded, fn address -> address.cep == cep end) do
      [] -> {:error, "CEP not found"}
      [address] -> {:ok, address}
    end
  end

  defp via_cep_api_response,
    do: File.read!("test/support/fixtures/via_cep_service/ceps.json")
end
