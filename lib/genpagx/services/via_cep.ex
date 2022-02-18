defmodule Genpagx.Services.ViaCEP do
  @moduledoc """
  Service responsble for validate and get address from ViaCep API Service via CEP.
  """
  @behaviour __MODULE__.Behaviour

  @impl true

  require Logger

  @spec validate_cep(binary()) :: {:ok, map()} | {:error, binary()}
  def validate_cep(cep) do
    case cep_is_valid?(cep) do
      true ->
        get_via_cep_url()
        |> replace_url_with_cep(cep)
        |> HTTPoison.get()
        |> handle_response(cep)

      false ->
        {:error, "Invalid postal code format"}
    end
  end

  defp get_via_cep_url,
    do: Keyword.get(Application.get_env(:genpagx, Genpagx.Services), :via_cep_url)

  defp replace_url_with_cep(url, cep), do: String.replace(url, ":zipcode", cep)

  defp handle_response(request, params) do
    case request do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        if Regex.match?(~r/erro/, body) do
          Logger.debug("CEP #{params} not found")
          {:error, "CEP not found"}
        else
          Logger.debug("Get CEP #{params} with success")
          {:ok, body_decoded} = Jason.decode(body, keys: :atoms)
          {:ok, body_decoded}
        end

      {:error, %HTTPoison.Error{reason: reason}} ->
        Logger.debug("Failed to get CEP with #{params} with error #{reason}")
        {:error, reason}
    end
  end

  defp cep_is_valid?(cep), do: Regex.match?(~r/^\d{5}-?\d{3}$/, cep)
end
