defmodule PbtSaldoBancario do

  @casas_decimais 2

  def transferir(saldo_atual, valor_transferido) 
  when (valor_transferido > saldo_atual), do: {:erro, :saldo_insuficiente}

  def transferir(saldo_atual, valor_transferido) do
    saldo_remanescente = saldo_atual - valor_transferido

    # Arredonda o saldo para cima, pois o cliente não pode ficar no prejuízo
    {:sucesso, Float.ceil(saldo_remanescente, @casas_decimais)}
  end

end
