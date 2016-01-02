defmodule EntrySpec do
  use ESpec
  alias Changelog.Entry

  describe "construction" do
    it "returns a valid record when given description text" do
      expect(Entry.new("foo")).to eq %Entry{text: "foo", indent: 0}
    end

    it "raises an error when given nil for description" do
      expect(fn -> Entry.new(nil) end).to raise_exception ArgumentError
    end

    it "raises an error when given an empty string" do
      expect(fn -> Entry.new("") end).to raise_exception ArgumentError
    end

    it "raises an error when given a blank string" do
      expect(fn -> Entry.new("    ") end).to raise_exception ArgumentError
    end

    it "accepts an indentation level" do
      expect(Entry.new("foo", 2)).to eq %Entry{text: "foo", indent: 2}
    end

    it "raises an error when indentation is negative" do
      expect(fn -> Entry.new("foo", -1) end).to raise_exception ArgumentError
    end
  end
end
