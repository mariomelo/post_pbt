defmodule PbtSaldoBancarioTest do
  use ExUnit.Case
  doctest PbtSaldoBancario

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


end
