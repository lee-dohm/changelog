defmodule EntrySpec do
  use ESpec
  alias Changelog.Entry

  describe "constructing" do
    describe "a basic entry" do
      describe "that is valid" do
        subject do: Entry.new("foo")

        it do: expect(subject.text).to eq "foo"
        it do: expect(subject.indent).to eq 0
      end

      describe "that is invalid" do
        it "raises an error when given nil for description" do
          expect(fn -> Entry.new(nil) end).to raise_exception ArgumentError
        end

        it "raises an error when given an empty string" do
          expect(fn -> Entry.new("") end).to raise_exception ArgumentError
        end

        it "raises an error when given a blank string" do
          expect(fn -> Entry.new("    ") end).to raise_exception ArgumentError
        end
      end

      describe "with an indentation level" do
        subject do: Entry.new("foo", 2)

        it do: expect(subject.text).to eq "foo"
        it do: expect(subject.indent).to eq 2

        it "raises an error when indentation is negative" do
          expect(fn -> Entry.new("foo", -1) end).to raise_exception ArgumentError
        end
      end
    end
  end
end
