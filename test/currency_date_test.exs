defmodule VDatex.CurrencyDateDate do
  use ExUnit.Case
  use ExUnitProperties
  alias StreamData, as: SD
  alias VDatex.CurrencyDate

  property "next_biz_day/2 is always one day after (assuming no weekends and holidays)" do
    check all curr_date <- gen_date() do
      cd = CurrencyDate.new([])

      assert Date.diff(CurrencyDate.next_biz_day(cd, curr_date), curr_date) == 1
    end
  end

  property "next_biz_day/2 never falls on weekends" do
    check all weekends <- gen_weekends(),
              curr_date <- gen_date() do
      cd = CurrencyDate.new(weekends)

      refute Date.day_of_week(CurrencyDate.next_biz_day(cd, curr_date)) in weekends
    end
  end

  property "next_biz_day/2 never falls on holidays" do
    check all curr_date <- gen_date(),
              holidays <- gen_holidays(curr_date) do
      cd = CurrencyDate.new()

      refute CurrencyDate.next_biz_day(cd, curr_date, holidays) in holidays
    end
  end

  defp gen_date(),
    do: SD.map(SD.positive_integer(), fn n -> Date.add(~D[2018-01-01], n) end)

  defp gen_weekends(),
    do: SD.map(SD.integer(1..6), fn n -> [n, n + 1] end)

  defp gen_holidays(curr_date) do
    SD.positive_integer()
    |> SD.list_of(min_length: 1)
    |> SD.map(fn ns ->
      Enum.map(MapSet.new(ns), fn n -> Date.add(curr_date, n) end)
    end)
  end
end
