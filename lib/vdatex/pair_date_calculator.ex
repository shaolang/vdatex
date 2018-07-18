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

defmodule VDatex.PairDateCalculator do
  alias __MODULE__
  alias VDatex.DateCalculator
  defstruct [:date_calc1, :date_calc2, :spot_lag]

  def new(date_calc1: date_calc1, date_calc2: date_calc2, spot_lag: spot_lag) do
    %PairDateCalculator{date_calc1: date_calc1, date_calc2: date_calc2,
     spot_lag: spot_lag}
  end

  def value(%PairDateCalculator{date_calc1: dc1, date_calc2: dc2} = pdc,
      _tenor, curr_date) do
    date1 = DateCalculator.next_biz_day(dc1, curr_date)
    date2 = DateCalculator.next_biz_day(dc2, curr_date)

    if date1 > date2 do
      date1
    else
      date2
    end
  end
end
