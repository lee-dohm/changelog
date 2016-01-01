defmodule EntryTest do
  use ExUnit.Case, async: true
  alias Changelog.Entry
  doctest Changelog.Entry

  test "new entry returns a valid entry record" do
    assert Entry.new("foo") == %Entry{text: "foo", indent: 0}
  end

  test "raises when description text is nil" do
    assert_raise ArgumentError, fn -> Entry.new(nil) end
  end

  test "raises when description text is empty" do
    assert_raise ArgumentError, fn -> Entry.new("") end
  end

  test "raises when description text is blank" do
    assert_raise ArgumentError, fn -> Entry.new("     ") end
  end

  test "new entry accepts an indentation level" do
    assert Entry.new("foo", 2) == %Entry{text: "foo", indent: 2}
  end

  test "raises when indent is negative" do
    assert_raise ArgumentError, fn -> Entry.new("foo", -1) end
  end
end
