defmodule FirstClassFunTest do
  use ExUnit.Case
  doctest FirstClassFun

  test "contains two" do
    assert FirstClassFun.lists_any([1,2,3],fn(e) -> e == 2 end) == :true
  end

  test "does not contain zero" do
    assert FirstClassFun.lists_any([1,2,3],fn(e) -> e == 0 end) == :false
  end

  test "contains five, using predicate generator" do
    test_list = [1,5,25]
    has_five? = FirstClassFun.equality_predicate(5)

    assert FirstClassFun.lists_any(test_list,has_five?) == :true
  end

  test "contains ten, using predicate generator" do
    test_list = [1,5,25]
    has_ten? = FirstClassFun.equality_predicate(10)

    assert FirstClassFun.lists_any(test_list,has_ten?) == :false
  end

  test "filter even numbers" do
    assert FirstClassFun.lists_filter([1,2,3,4,5],fn(e) -> rem(e,2) == 0 end) == [2,4]
  end
end
