defmodule ExBlockchain.BlockTest do
  use ExUnit.Case, async: true

  alias ExBlockchain.Block

  test "generate" do
    block = Block.generate("previous_hash", "timestamp")

    assert block.previous_hash == "previous_hash"
    assert block.timestamp == "timestamp"
    assert block.hash == "54fb1baa2de718ddf203b3e684ff44b850c02797606b90f4c311bfd7c98a47ab"
  end
end
