defmodule Stack.Server do
  use GenServer

  def start_link(stack) do
    GenServer.start_link(__MODULE__, stack, name: __MODULE__)
  end

  def pop do
    GenServer.call(__MODULE__, :pop)
  end

  def push(element) do
    GenServer.cast(__MODULE__, {:push, element})
  end

  def terminate(reason, state) do
    IO.puts "Terminating for reason: #{inspect reason} state: '#{inspect state}'"
  end

  def format_status(_reason, [_pdict, state]) do
    [data: [{'State', "My current state is '#{inspect state}', and I'm happy"}]]
  end

  def handle_call(:pop, _from, stack) do
    { head, tail } = _pop(stack)
    { :reply, head, tail }
  end

  def handle_cast({:push, element}, stack) do
    { :noreply, [ element | stack ] }
  end

  defp _pop([head | tail]), do: { head, tail }
end
