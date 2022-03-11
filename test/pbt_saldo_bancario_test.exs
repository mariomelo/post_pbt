defmodule PbtSaldoBancarioTest do
  use ExUnit.Case
  doctest PbtSaldoBancario
  use PropCheck

  test "Caso não haja saldo suficiente, a transferência não pode ser efetuada" do
    saldo_atual = 10.00
    valor_transferido = 24.99
    {:erro, :saldo_insuficiente} = PbtSaldoBancario.transferir(saldo_atual, valor_transferido) 
  end

  test "O cliente não pode tomar prejuízo ao realizar uma transferência" do
    saldo_atual = 100.00
    valor_transferido = 25.00
    {:sucesso, 75.00} = PbtSaldoBancario.transferir(saldo_atual, valor_transferido) 
  end

  property "O cliente consegue transferir qualquer valor desde que tenha saldo suficiente" do

    forall saldo_inicial_float <- float(0, :inf) do

      saldo_inicial = Float.round(saldo_inicial_float, 2)

      forall transferencia_float <- float(:inf, saldo_inicial) do

        transferencia = Float.round(transferencia_float, 2)
        {:sucesso, saldo_restante} = PbtSaldoBancario.transferir(saldo_inicial, transferencia)

        saldo_inicial == Float.round(saldo_restante + transferencia, 2) and
        saldo_restante <= saldo_inicial
      end
    end

  end

end
