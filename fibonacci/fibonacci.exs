defmodule Fib do
  def fib(a, _, 0 ) do a end
  def fib(a, b, n) do fib(b, a+b, n-1) end
  def fib(n) do
    0..n
    |> Enum.map(fn(n) -> fib(1, 1, n) end)
  end
end
