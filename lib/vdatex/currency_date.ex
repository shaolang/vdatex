defmodule VDatex.CurrencyDate do
  alias __MODULE__

  defstruct [:weekends]

  def new(weekends \\ [6, 7]), do: %CurrencyDate{weekends: weekends}

  def next_biz_day(
        %CurrencyDate{weekends: weekends} = vdate,
        curr_date,
        holidays \\ []
      ) do
    result = Date.add(curr_date, 1)

    if Date.day_of_week(result) in weekends or result in holidays do
      next_biz_day(vdate, result, holidays)
    else
      result
    end
  end
end
