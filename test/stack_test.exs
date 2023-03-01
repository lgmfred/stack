defmodule StackTest do
  use ExUnit.Case
  doctest Stack

  describe "start_link/1" do
    test "with no configuration" do
      {:ok, pid} = Stack.start_link()
      assert Process.alive?(pid)
      assert Stack.get_state(pid) == []
    end

    test "with a default state" do
      {:ok, pid} = Stack.start_link([2, 1])
      assert Process.alive?(pid)
      assert Stack.get_state(pid) == [2, 1]
    end
  end

  describe "push/2" do
    test "an element onto an empty stack" do
      {:ok, pid} = Stack.start_link()
      assert Stack.push(pid, 1) == [1]
    end

    test "an element onto a stack with one element" do
      {:ok, pid} = Stack.start_link([7])
      assert Stack.push(pid, 9) == [9, 7]
    end

    test "an element onto a stack with multiple elements" do
      {:ok, pid} = Stack.start_link()
      for n <- 1..5, do: Stack.push(pid, n)
      assert Stack.push(pid, 6) == [6, 5, 4, 3, 2, 1]
    end
  end

  describe "pop/1" do
    test "an empty stack" do
      {:ok, pid} = Stack.start_link()
      assert Stack.pop(pid) == nil
    end

    test "a stack with one element" do
      {:ok, pid} = Stack.start_link([11])
      assert Stack.pop(pid) == 11
      assert Stack.get_state(pid) == []
    end

    test "a stack with multiple elements" do
      {:ok, pid} = Stack.start_link()
      for n <- 5..10, do: Stack.push(pid, n)
      assert Stack.pop(pid) == 10
      assert Stack.pop(pid) == 9
    end
  end
end
