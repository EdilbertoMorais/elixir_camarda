defmodule ExMon do
  alias ExMon.Trainer

  defdelegate create_trainer(params), to: Trainer.Create, as: :call
  defdelegate delete_trainer(params), to: Trainer.Delete, as: :call
  defdelegate fecth_trainer(params), to: Trainer.Get, as: :call
end
