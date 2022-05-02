defmodule ExBlockchain.BlockTest do
  use ExUnit.Case, async: true

  alias ExBlockchain.Block

  test "generate" do
    block = Block.generate("previous_hash", "timestamp", "data", 1)

    assert block.previous_hash == "previous_hash"
    assert block.timestamp == "timestamp"
    assert block.hash == "047120f7ec3faedb4a56fe95f59e3876a352c43913823056c2fe085705af0d24"
  end
end
