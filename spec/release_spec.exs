defmodule ReleaseSpec do
  use ESpec
  alias Changelog.Release

  describe "constructing" do
    let :default_version do
      {:ok, version} = Version.parse("0.0.1")
      version
    end

    let :version do
      {:ok, version} = Version.parse("1.0.0")
      version
    end

    let :today do
      {today, _} = :calendar.local_time
      today
    end

    context "with no parameters" do
      subject do: Release.new

      it do: expect(subject.version).to eq default_version
      it do: expect(subject.date).to eq today
      it do: expect(subject.entries).to eq []
    end

    context "with a valid version" do
      subject do: Release.new("1.0.0")

      it do: expect(subject.version).to eq version
      it do: expect(subject.date).to eq today
      it do: expect(subject.entries).to eq []
    end

    context "with a valid version and date" do
      subject do: Release.new("1.0.0", "2015-01-23")

      it do: expect(subject.version).to eq version
      it do: expect(subject.date).to eq {2015, 1, 23}
      it do: expect(subject.entries).to eq []
    end

    it "raises when given an invalid version" do
      expect(fn ->
        Release.new("blah blah blah")
      end).to raise_exception Release.InvalidVersionError
    end

    it "raises when given an invalid date" do
      expect(fn ->
        Release.new("1.0.0", "2015-13-35")
      end).to raise_exception Release.InvalidDateError
    end
  end
end
