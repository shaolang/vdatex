# Copyright 2018 Shaolang Ai
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

defmodule VDatex.DateCalculatorTest do
  use VDatexCase
  alias VDatex.DateCalculator, as: DCal

  property "next_biz_day/2 is always one day after (assuming no weekends and holidays)" do
    check all curr_date <- gen_date() do
      dc = DCal.new([])

      assert Date.diff(DCal.next_biz_day(dc, curr_date), curr_date) == 1
    end
  end

  property "next_biz_day/2 never falls on weekends" do
    check all weekends <- gen_weekends(),
              curr_date <- gen_date() do
      dc = DCal.new(weekends)

      refute Date.day_of_week(DCal.next_biz_day(dc, curr_date)) in weekends
    end
  end

  property "next_biz_day/2 never falls on holidays" do
    check all curr_date <- gen_date(),
              holidays <- gen_holidays(curr_date) do
      dc = DCal.new()

      refute DCal.next_biz_day(dc, curr_date, holidays) in holidays
    end
  end
end
