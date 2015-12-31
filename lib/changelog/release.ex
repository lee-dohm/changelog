defmodule Changelog.Release do
  alias Changelog.Release

  defmodule InvalidDateError do
    defexception [:message]
  end

  defmodule InvalidVersionError do
    defexception [:message]
  end

  defstruct version: Kernel.elem(Version.parse("0.0.1"), 1),
            date: Kernel.elem(:calendar.local_time, 0),
            entries: []

  def new(version \\ "0.0.1", date \\ today, entries \\ []) do
    version = validate_version!(version)
    date = convert_date(date)

    %Release{version: version, date: date, entries: entries}
  end

  defp convert_date(date) when is_binary(date) do
    validate_date!(date)
  end

  defp convert_date(date) when is_tuple(date) do
    case date do
      {_year, _month, _day} -> date
      {date, _time} -> date
    end
  end

  defp convert_date(date) do
    date
  end

  defp today do
    {today, _} = :calendar.local_time

    today
  end

  defp validate_date!(date) do
    case Timex.DateFormat.parse(date, "%Y-%m-%d", :strftime) do
      {:ok, %Timex.DateTime{year: year, month: month, day: day}} -> {year, month, day}
      {:error, message} -> raise InvalidDateError, message: message
    end
  end

  defp validate_version!(version) do
    case Version.parse(version) do
      {:ok, valid_version} -> valid_version
      :error -> raise InvalidVersionError, message: "Error parsing version: #{version}"
    end
  end
end
