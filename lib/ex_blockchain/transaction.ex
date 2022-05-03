defmodule ExBlockchain.Transaction do
  @moduledoc false
  @enforced_keys [:from_address, :to_address, :amount, :timestamp]
  @derive Jason.Encoder
  defstruct [:from_address, :to_address, :amount, :timestamp]

  @type t() :: %__MODULE__{
          from_address: String.t(),
          to_address: String.t(),
          amount: Number.t(),
          timestamp: String.t()
        }
end
