defmodule VDatex.CurrencyDateDate do
  use ExUnit.Case
  use ExUnitProperties
  alias StreamData, as: SD
  alias VDatex.CurrencyDate

  property "next_biz_day/2 never falls on weekends" do
    check all weekends <- gen_weekends(),
              curr_date <- gen_date() do
      vdate = CurrencyDate.new(weekends)

      refute Date.day_of_week(CurrencyDate.next_biz_day(vdate, curr_date)) in weekends
    end
  end

  defp gen_date(),
    do: SD.map(SD.positive_integer(), fn n -> Date.add(~D[2018-01-01], n) end)

  defp gen_weekends(),
    do: SD.map(SD.integer(1..6), fn n -> [n, n + 1] end)
end
