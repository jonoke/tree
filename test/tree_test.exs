defmodule Tree23Test do
  use ExUnit.Case
  doctest Tree23

  test "null tree" do
    aTree = %Tree23{}
    assert aTree.a == nil
    assert aTree.b == nil
    assert aTree.x == nil
    assert aTree.y == nil
    assert aTree.z == nil
  end

  test "simple add 1" do
    bTree = Tree23.add("A")
    assert bTree.a == "A"
    assert bTree.b == nil
  end
  test "simple add 2" do
    bTree = Tree23.add("A")
    cTree = Tree23.add(bTree, "B")
    assert cTree.a == "A"
    assert cTree.b == "B"
  end
  test "simple insert 1" do
    bTree = Tree23.add("B")
    cTree = Tree23.add(bTree, "A")
    assert cTree.a == "A"
    assert cTree.b == "B"
  end
  test "simple split" do
    bTree = Tree23.add("D")
    cTree = Tree23.add(bTree, "A")
    dTree = Tree23.add(cTree, "E")
    assert dTree.a == "D"
    assert dTree.b == nil
    assert dTree.x == %Tree23{a: "A"}
    assert dTree.y == %Tree23{a: "E"}
  end
  test "simple split with raise from x" do
    aTree = Tree23.add("D")
    aTree = Tree23.add(aTree, "A")
    aTree = Tree23.add(aTree, "E")
    assert aTree.a == "D"
    assert aTree.b == nil
    assert aTree.x == %Tree23{a: "A"}
    assert aTree.y == %Tree23{a: "E"}
    aTree = Tree23.add(aTree, "B")
    assert aTree.x == %Tree23{a: "A", b: "B"}
    assert aTree.y == %Tree23{a: "E"}
    aTree = Tree23.add(aTree, "C")
    assert aTree.a == "B"
    assert aTree.b == "D"
    assert aTree.x == %Tree23{a: "A"}
    assert aTree.y == %Tree23{a: "C"}
    assert aTree.z == %Tree23{a: "E"}
  end
  test "simple split with raise from y" do
    aTree = Tree23.add("D")
    aTree = Tree23.add(aTree, "A")
    aTree = Tree23.add(aTree, "E")
    aTree = Tree23.add(aTree, "F")
    assert aTree.a == "D"
    assert aTree.x == %Tree23{a: "A"}
    assert aTree.y == %Tree23{a: "E", b: "F"}
    aTree = Tree23.add(aTree, "G")
    assert aTree.a == "D"
    assert aTree.b == "F"
    assert aTree.x == %Tree23{a: "A"}
    assert aTree.y == %Tree23{a: "E"}
    assert aTree.z == %Tree23{a: "G"}
  end
  test "simple split with raise from z" do
    IO.puts "simple split with raise from z"
    aTree = Tree23.add("D")
    aTree = Tree23.add(aTree, "A")
    aTree = Tree23.add(aTree, "E")
    aTree = Tree23.add(aTree, "F")
    assert aTree.a == "D"
    assert aTree.x == %Tree23{a: "A"}
    assert aTree.y == %Tree23{a: "E", b: "F"}
    aTree = Tree23.add(aTree, "G")
    aTree = Tree23.add(aTree, "H")
    assert aTree.a == "D"
    assert aTree.b == "F"
    assert aTree.x == %Tree23{a: "A"}
    assert aTree.y == %Tree23{a: "E"}
    assert aTree.z == %Tree23{a: "G", b: "H"}
    aTree = Tree23.add(aTree, "I")
    assert aTree.a == "F"
    assert aTree.x.a == "D"
    assert aTree.x.x.a == "A"
    assert aTree.x.y.a == "E"
    assert aTree.y.a == "H"
    assert aTree.y.x.a == "G"
    assert aTree.y.y.a == "I"
  end
  test "complex split with raise from y" do
    IO.puts "complex split with raise from y"
    aTree = Tree23.add("D")
    aTree = Tree23.add(aTree, "A")
    aTree = Tree23.add(aTree, "E1")
    aTree = Tree23.add(aTree, "F")
    aTree = Tree23.add(aTree, "G")
    aTree = Tree23.add(aTree, "H")
    aTree = Tree23.add(aTree, "I")
    aTree = Tree23.add(aTree, "E2")
    assert aTree.a == "F"
    assert aTree.x.a == "D"
    assert aTree.x.x.a == "A"
    assert aTree.x.y.a == "E1"
    assert aTree.x.y.b == "E2"
    assert aTree.y.a == "H"
    assert aTree.y.x.a == "G"
    assert aTree.y.y.a == "I"

    aTree = Tree23.add(aTree, "E3")
    assert aTree.a == "F"
    assert aTree.x.a == "D"
    assert aTree.x.b == "E2"
    assert aTree.x.x.a == "A"
    assert aTree.x.y.a == "E1"
    assert aTree.x.z.a == "E3"
    assert aTree.y.a == "H"
    assert aTree.y.x.a == "G"
    assert aTree.y.y.a == "I"
  end

  test "add find fail" do
    IO.puts "add find success"
    aTree = Tree23.add("A")
    assert Tree23.find(aTree, "B") == nil
  end
  test "add find success" do
    IO.puts "add find success"
    aTree = Tree23.add("A")
    assert Tree23.find(aTree, "A") == "A"
    aTree = Tree23.add(aTree, "D")
    assert Tree23.find(aTree, "D") == "D"
    aTree = Tree23.add(aTree, "G")
    assert Tree23.find(aTree, "G") == "G"
    aTree = Tree23.add(aTree, "H")
    assert Tree23.find(aTree, "H") == "H"
    aTree = Tree23.add(aTree, "E")
    assert Tree23.find(aTree, "H") == "H"
    assert Tree23.find(aTree, "E") == "E"
    aTree = Tree23.add(aTree, "F")
    assert Tree23.find(aTree, "H") == "H"
    assert Tree23.find(aTree, "F") == "F"
    assert Tree23.find(aTree, "E") == "E"
    assert Tree23.find(aTree, "D") == "D"
    assert Tree23.find(aTree, "H") == "H"
  end
  @tag :specific
  test "specific add fail" do
    IO.puts "specific add fail"
    aTree = Tree23.add(74)
    assert Tree23.find(aTree, 74) == 74
    aTree = Tree23.add(aTree, 18)
    assert Tree23.find(aTree, 18) == 18
    aTree = Tree23.add(aTree, 88)
    assert Tree23.find(aTree, 88) == 88
    aTree = Tree23.add(aTree, 55)
    assert Tree23.find(aTree, 55) == 55
    aTree = Tree23.add(aTree, 13)
    assert Tree23.find(aTree, 13) == 13
    aTree = Tree23.add(aTree, 98)
    assert Tree23.find(aTree, 98) == 98
    aTree = Tree23.add(aTree, 42)
    assert Tree23.find(aTree, 42) == 42
    IO.inspect aTree
    aTree = Tree23.add(aTree, 73)
    IO.puts "---"
    IO.inspect aTree
    assert Tree23.find(aTree, 73) == 73
  end
  def do_test(n, rangeTop, aTree\\%Tree23{}, aMapSet\\MapSet.new([]))
  def do_test(0, _rangeTop, aTree, aSet) do
    assert Enum.all?((for x <- aSet, do: Tree23.find(aTree, x) == x), fn(y) -> y end)
    aTree
  end
  def do_test(n, rangeTop, aTree, aSet) do
    aValue = Enum.random(0..rangeTop)
    case MapSet.member?(aSet,aValue) do
      true ->
	IO.puts "hit #{aValue}"
	do_test(n-1, rangeTop, aTree, aSet)
      false ->
	IO.puts "#{n} #{aValue}"
	aTree = Tree23.add(aTree, aValue)
	aSet = MapSet.put(aSet, aValue)
	if Tree23.find(aTree, aValue) == nil do
	  IO.puts "FAIL FAIL"
	  IO.inspect(aTree)
	end
	assert Tree23.find(aTree, aValue) == aValue
	do_test(n-1, rangeTop, aTree, aSet)
	#do_test(n-1, rangeTop, Tree23.add(aTree, aValue), MapSet.put(aSet, aValue))
    end
  end
  @tag :long
  test "random add check" do
    IO.puts "random find success"
    aTree = do_test(200, 100)
    IO.inspect aTree
    assert 1 == 1
  end
end
