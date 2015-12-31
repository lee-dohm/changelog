defmodule EntryTest do
  use ExUnit.Case, async: true
  alias Changelog.Entry
  doctest Changelog.Entry

  test "new entry returns text formatted as unordered list item" do
    assert Entry.new("foo") == "* foo"
  end

  test "new fix returns text with link to bug tracker" do
    entry = Entry.new_fix("1234", "https://github.com/lee-dohm/changelog/issues/1234", "foo")

    assert entry == "* [#1234](https://github.com/lee-dohm/changelog/issues/1234) foo"
  end

  test "new pull request returns text with link to bug tracker" do
    entry = Entry.new_pull_request(
              "1234",
              "https://github.com/lee-dohm/changelog/pulls/1234",
              "someuser",
              "https://someuser.com",
              "foo")

    assert entry == "* [PR #1234](https://github.com/lee-dohm/changelog/pulls/1234) by [someuser](https://someuser.com) - foo"
  end

  test "new pull request with list of descriptions returns a list of strings" do
    entries = Entry.new_pull_request(
                "1234",
                "https://github.com/lee-dohm/changelog/pulls/1234",
                "someuser",
                "https://someuser.com",
                ["foo", "bar", "baz"])

    assert entries == [
        "* [PR #1234](https://github.com/lee-dohm/changelog/pulls/1234) by [someuser](https://someuser.com)",
        "    * foo",
        "    * bar",
        "    * baz"
      ]
  end
end
