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

defmodule VDatex.DateCalculator do
  alias __MODULE__

  defstruct [:weekends]

  def new(weekends \\ [6, 7]), do: %DateCalculator{weekends: weekends}

  def next_biz_day(
        %DateCalculator{weekends: weekends} = vdate,
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
