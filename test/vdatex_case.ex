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

defmodule VDatexCase do
  use ExUnit.CaseTemplate
  alias VDatex.DateCalculator

  def gen_date() do
    StreamData.positive_integer
    |> StreamData.map(fn n -> Date.add(~D[2018-01-01], n) end)
  end

  def gen_date_calculator() do
    StreamData.integer(1..6)
    |> StreamData.map(fn n -> DateCalculator.new([n, n+1]) end)
  end

  def gen_holidays(curr_date) do
    StreamData.positive_integer()
    |> StreamData.list_of(min_length: 1)
    |> StreamData.map(fn ns ->
      Enum.map(MapSet.new(ns), fn n -> Date.add(curr_date, n) end)
    end)
  end

  def gen_weekends(),
    do: StreamData.map(StreamData.integer(1..6), fn n -> [n, n + 1] end)

  using do
    quote do
      use ExUnitProperties
      import VDatexCase
    end
  end
end
