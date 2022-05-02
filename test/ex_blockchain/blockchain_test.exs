defmodule ExBlockchain.BlockchainTest do
  use ExUnit.Case, async: true
  alias ExBlockchain.{Blockchain, Block}

  test "generate" do
    blockchain = Blockchain.generate()

    assert length(blockchain.chain) == 1
  end

  describe "is_chain_valid?" do
    setup do
      blockchain = Blockchain.generate()
      blockchain = Blockchain.add_new_block(blockchain)
      blockchain = Blockchain.add_new_block(blockchain)
      blockchain = Blockchain.add_new_block(blockchain)

      {:ok, blockchain: blockchain}
    end

    test "valid chain", %{blockchain: blockchain} do
      assert Blockchain.is_blockchain_valid?(blockchain)
    end

    test "invalid chain", %{blockchain: blockchain} do
      random_block = Block.generate("not_exists_hash", "timestamp", nil)

      invalid_blokchain = %Blockchain{chain: blockchain.chain ++ [random_block]}

      refute Blockchain.is_blockchain_valid?(invalid_blokchain)
    end
  end
end
