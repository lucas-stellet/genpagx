defmodule Genpagx.Services.ViaCEPTest do
  @moduledoc false

  use ExUnit.Case, async: true

  alias Genpagx.Services.ViaCEP.Mock, as: ViaCEPService

  describe "validate_cep/1" do
    test "pass a valid CEP and returns it successfully" do
      cep = "01001-000"

      assert {:ok, address} = ViaCEPService.validate_cep(cep)

      assert address.cep == cep
    end

    test "pass a invalid CEP and returns error tuple" do
      cep = "00000-000"

      assert {:error, "CEP not found"} = ViaCEPService.validate_cep(cep)
    end
  end
end
