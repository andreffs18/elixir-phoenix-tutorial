defmodule Fib.Timer do

  def time(func, arglist) do
    t0 = Time.utc_now
    apply(func, arglist)
    t1 = Time.utc_now
    Time.diff(t1, t0, :millisecond)
  end

end