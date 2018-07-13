defmodule VDatex.CurrencyDateDate do
  use ExUnit.Case
  use ExUnitProperties
  alias VDatex.CurrencyDate

  property "next_biz_day/2 never falls on weekends" do
    check all day <- StreamData.integer(1..6),
              to_add <- StreamData.positive_integer() do
      weekends = [day, day + 1]
      vdate = CurrencyDate.new(weekends)

      curr_date = Date.new(2018, 1, 1) |> elem(1) |> Date.add(to_add)

      refute Date.day_of_week(CurrencyDate.next_biz_day(vdate, curr_date)) in weekends
    end
  end
end
