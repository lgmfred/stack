defmodule Stack do
  @moduledoc """
  A very dump implementation of the `Stack` date structure using lists.
  """
  use GenServer

  @doc """
  Start the Stack server with an initial state with `[]` as the default.

  ## Examples

      iex> {:ok, pid1} = Stack.start_link()
      iex> Process.alive?(pid1)
      true

      iex> {:ok, pid2} = Stack.start_link([5, 6, 7])
      iex> Process.alive?(pid2)
      true
  """
  @spec start_link(maybe_improper_list) :: :ignore | {:error, any} | {:ok, pid}
  def start_link(default \\ []) when is_list(default) do
    GenServer.start_link(__MODULE__, default)
  end

  @doc """
  Push an element to the stack

  ## Examples

      iex> {:ok, pid} = Stack.start_link()
      iex> Stack.push(pid, 9)
      [9]
      iex> Stack.push(pid, 77)
      [77, 9]
  """
  @spec push(pid, any) :: list
  def push(pid, element) do
    GenServer.call(pid, {:push, element})
  end

  @doc """
  Pop an element from the stack

  ## Examples

      iex> {:ok, pid} = Stack.start_link([6, 1])
      iex> Stack.pop(pid)
      6
      iex> Stack.pop(pid)
      1
      iex> Stack.pop(pid)
      nil
  """
  @spec pop(pid) :: any
  def pop(pid) do
    GenServer.call(pid, :pop)
  end

  @doc """
  Get the stack (state of the server)

  ## Examples

      iex> {:ok, pid} = Stack.start_link([6, 1, 7])
      iex> Stack.get_state(pid)
      [6, 1, 7]
  """
  @spec get_state(pid) :: list
  def get_state(stack_pid) do
    GenServer.call(stack_pid, :get_state)
  end

  @impl true
  @spec init(list) :: {:ok, list}
  def init(init_state) do
    {:ok, init_state}
  end

  @impl true
  def handle_call(:get_state, _from, state) do
    {:reply, state, state}
  end

  def handle_call({:push, element}, _from, state) do
    new_state = [element | state]
    {:reply, new_state, new_state}
  end

  def handle_call(:pop, _from, [] = state) do
    {:reply, nil, state}
  end

  def handle_call(:pop, _from, [head | tail] = _state) do
    {:reply, head, tail}
  end
end
