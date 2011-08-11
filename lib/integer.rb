module Fibonacci
  def closest_fibonacci

    raise "method 'closest_fibonacci' is not available for negative integers" if self < 0

    sequence = [0, 1]
    sequence << sequence[sequence.size-2] + sequence.last while sequence.last <= self

    sequence[sequence.size-2]
  end
end


class Integer
  include Fibonacci
end