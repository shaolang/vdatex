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

defmodule VDatex.PairDateCalculatorTest do
  use ExUnit.Case
  use ExUnitProperties
  alias VDatex.PairDateCalculator
  alias VDatex.DateCalculator

  property "value spot does not fall on weekends" do
    check all %{weekends: we1} = dc1 <- gen_date_calculator(),
              %{weekends: we2} = dc2 <- gen_date_calculator(),
              curr_date <- gen_date() do
      pdc = PairDateCalculator.new(date_calc1: dc1, date_calc2: dc2, spot_lag: 2)
      all_weekends = we1 ++ we2

      refute PairDateCalculator.value(pdc, :spot, curr_date) in all_weekends
    end
  end

  def gen_date_calculator() do
    StreamData.integer(1..6)
    |> StreamData.map(fn n -> DateCalculator.new([n, n+1]) end)
  end

  def gen_date() do
    StreamData.positive_integer
    |> StreamData.map(fn n -> Date.add(~D[2018-01-01], n) end)
  end
end
