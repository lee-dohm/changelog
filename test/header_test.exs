defmodule HeaderTest do
  use ExUnit.Case, async: true
  alias Changelog.Header
  doctest Changelog.Header

  test "default header includes no description text" do
    assert Header.new == ["# CHANGELOG"]
  end

  test "when given a description it includes it" do
    assert Header.new("foo") == ["# CHANGELOG", "", "foo"]
  end

  test "when given a longer description it includes it" do
    assert Header.new(["foo", "bar", "baz"]) == ["# CHANGELOG", "", "foo", "bar", "baz"]
  end
end
