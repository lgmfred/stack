# Stack

A [stack](https://en.wikipedia.org/wiki/Stack_(abstract_data_type)) is a data structure which can push elements onto the top of the stack and pop them off of the top of the stack.

This is junky Stack process created using [GenServer](https://hexdocs.pm/elixir/GenServer.html) which stores a stack as a list of elements in it's state. You should be able to send a `{:push, element}` message and a `:pop` message to add and remove elements from the beginning of the list.

This is intended as a way of learning and testing `GenServer`s in [DockYard Academy](https://github.com/DockYard-Academy/curriculum).

## Installation

Install Elixir by following the [Elixir Installation Guide](https://elixir-lang.org/install.html).

Clone the repository.
```shell
$ git clone https://github.com/lgmfred/stack.git
$ cd stack
```

Install dependencies.

```elixir
$ mix deps.get
```
Run tests and ensure they all pass.

```shell
$ mix test
```
Generate docs (if you like).

```sell
$ mix docs
```
## Running the program

Start the IEx shell.

```shell
$ iex -S mix
```
Then in the IEx shell:

```elixir
iex(1)> {:ok, pid} = Stack.start_link()
{:ok, #PID<0.230.0>}
iex(2)> Stack.get_state(pid)
[]
iex(3)> Stack.push(pid, :a)
[:a]
iex(4)> Stack.push(pid, :b)
[:b, :a]
iex(5)> Stack.get_state(pid)
[:b, :a]
iex(6)> Stack.push(pid, :c) 
[:c, :b, :a]
iex(7)> Stack.get_state(pid)
[:c, :b, :a]   
iex(8)> Stack.pop(pid)
:c
iex(9)> Stack.get_state(pid)
[:b, :a]
iex(10)> Stack.pop(pid)
:b
iex(11)> Stack.pop(pid)
:a
iex(12)> Stack.pop(pid)
nil
iex(13)> Stack.get_state(pid)
[]
```

## Concepts learned

- GenServer
- TDD (Test-driven Development)
- Testing GenServers (testing behaviour instead of implementation)
- DocTests, ..etc.

