defmodule ReleaseTest do
  use ExUnit.Case, async: true
  alias Changelog.Release
  doctest Changelog.Release

  setup do
    {:ok, version} = Version.parse("0.0.1")
    {today, _} = :calendar.local_time

    {:ok, today: today, version: version}
  end

  test "new returns default struct", defaults do
    assert Release.new == %Release{version: defaults[:version], date: defaults[:today], entries: []}
  end

  test "new with valid version returns valid struct", defaults do
    {:ok, version} = Version.parse("1.0.0")

    assert Release.new("1.0.0") == %Release{version: version, date: defaults[:today], entries: []}
  end

  test "new with invalid version raises" do
    assert_raise Release.InvalidVersionError, fn -> Release.new("blah blah blah") end
  end

  test "new with valid date returns valid struct", defaults do
    assert Release.new("0.0.1", "2015-01-23") == %Release{version: defaults[:version], date: {2015, 1, 23}, entries: []}
  end

  test "new with invalid date raises" do
    assert_raise Release.InvalidDateError, fn -> Release.new("0.0.1", "2015-13-35") end
  end
end
