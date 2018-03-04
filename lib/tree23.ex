defmodule Tree23 do
  @moduledoc """
    23 Trees exploration
  """

  @doc """
   23 Trees

  ## Examples

      iex> Tree23.hello
      :world

  """

  defstruct a: nil, b: nil, x: nil, y: nil, z: nil

  def hello(), do: :world

  def adder(%Tree23{a: nil}, aValue),                               do: {:ok, %Tree23{a: aValue}}
  def adder(%Tree23{a: a, b: nil, x: nil}, aValue) when aValue < a, do: {:ok, %Tree23{a: aValue, b: a}}
  def adder(%Tree23{a: a, b: nil, x: nil}, aValue) when aValue > a, do: {:ok, %Tree23{a: a, b: aValue}}

  def adder(%Tree23{a: a, b: b, x: nil}, aValue)   when aValue < a do
    IO.puts "A A A #{aValue}"
    {:split, {a, %Tree23{a: aValue}, %Tree23{a: b}}}
  end
  def adder(%Tree23{a: a, b: b, x: nil}, aValue)   when aValue > b do
    IO.puts "C C C #{aValue}"
    {:split, {b, %Tree23{a: a}, %Tree23{a: aValue}}}
  end
  def adder(%Tree23{a: a, b: b, x: nil}, aValue)                    do
    IO.puts "B B B #{aValue}"
    {:split, {aValue, %Tree23{a: a}, %Tree23{a: b}}}
  end

  def adder(%Tree23{a: a, b: b, x: x, y: y, z: z}, aValue) when aValue < a do
    #IO.puts "v<a #{aValue}"
    case adder(x, aValue) do
      {:ok, result} -> {:ok, %Tree23{a: a, b: b, x: result, y: y, z: z}}
      {:split, {splitValue, left, right}} ->
      IO.puts "AA"
      case b do
	nil ->
	  {:ok, %Tree23{a: splitValue, b: a, x: left, y: right, z: y}}
	_ ->
	  {:split, {a, %Tree23{a: splitValue, x: left, y: right}, %Tree23{a: b, x: y, y: z}}}
      end
    end
  end
  def adder(%Tree23{a: a, b: b, x: x, y: y, z: z}, aValue) when b == nil or aValue < b do
    #IO.puts "v>a #{aValue}"
    case adder(y, aValue) do
      {:ok, result} -> {:ok, %Tree23{a: a, b: b, x: x, y: result, z: z}}
      {:split, {splitValue, left, right}} ->
      case b do
	nil ->
	  {:ok, %Tree23{a: a, b: splitValue, x: x, y: left, z: right}}
	_ ->
      IO.puts "BB"
	  {:split, {splitValue, %Tree23{a: a, x: x, y: left}, %Tree23{a: b, x: right, y: z}}}
      end
    end
  end
  def adder(%Tree23{a: a, b: b, x: x, y: y, z: z}, aValue) when b < aValue do
    #IO.puts "v>b #{aValue}"
    case adder(z, aValue) do
      {:ok, result} -> {:ok, %Tree23{a: a, b: b, x: x, y: y, z: result}}
      {:split, {splitValue, left, right}} ->
	case b do
	  nil ->
	    {:ok, %Tree23{a: a, b: splitValue, x: x, y: left, z: right}}
	  _ ->
      IO.puts "CC"
	    {:split, {b, %Tree23{a: a, x: x, y: y}, %Tree23{a: splitValue, x: left, y: right}}}
	end
    end
  end

  def add(aTree \\ nil, aValue)
  # Add to null tree
  def add(nil, aValue), do: %Tree23{a: aValue}
  def add(aTree, aValue) do
    case adder(aTree, aValue) do
      {:ok, result} ->
	#IO.puts ":OK"
	result
      {:split, {value,left,right}} ->
	#IO.puts ":split"
	%Tree23{a: value, x: left, y: right}
    end
  end

  def find(nil, _aValue), do: nil
  def find(%Tree23{a: a, b: _b}, aValue) when a == aValue do
    #IO.puts "find {#{a}, #{b}} a: #{aValue}"
    a
  end
  def find(%Tree23{a: _a, b: b}, aValue) when b == aValue do
    #IO.puts "find {#{a}, #{b}} b: #{aValue}"
    b
  end
  def find(%Tree23{a: a, b: _b, x: x}, aValue) when aValue < a do
    #IO.puts "find {#{a}, #{b}} : #{aValue} -> x"
    find(x, aValue)
  end
  def find(%Tree23{a: a, b: b, y: y}, aValue) when aValue > a and b == nil or b != nil and aValue < b do
    #IO.puts "find {#{a}, #{b}} : #{aValue} -> y"
    find(y, aValue)
  end
  def find(%Tree23{a: _a, b: b, z: z}, aValue) when b < aValue do
    #IO.puts "find {#{a}, #{b}} : #{aValue} -> z"
    find(z, aValue)
  end
  def find(%Tree23{a: _a, b: _b, y: y}, aValue) do
    #IO.puts "find {#{a}, #{b}} : #{aValue} -> y"
    find(y, aValue)
  end
end
