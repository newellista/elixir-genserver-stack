defmodule Stack.Stack do
  use GenServer

  def handle_call(:pop, _from, stack) do
    { head, tail } = _pop(stack)
    { :reply, head, tail }
  end

  def handle_cast({:push, new_number}, stack) do
    { :noreply, [ new_number | stack ] }
  end

  defp _pop([head | tail]), do: { head, tail }
end
