require "test_helper"
require "integer"

class TestInteger < ActiveSupport::TestCase

  context "spot regression testing:  " do
    context "an integer/fixnum/bignum" do
      should "retain core Integer behavior" do
        test_fixnum = 4
        assert_equal Fixnum, test_fixnum.class
        assert test_fixnum.is_a? Fixnum
        assert test_fixnum.is_a? Integer
        assert test_fixnum.is_a? Numeric
        assert test_fixnum.is_a? Precision
        assert test_fixnum.is_a? Object
        assert test_fixnum.integer?
        assert test_fixnum == 4
        assert test_fixnum.eql? 4
        four = 4
        assert test_fixnum == four
        assert test_fixnum.eql? four
        assert test_fixnum == 4.0
        assert !test_fixnum.eql?(4.0)
        assert !test_fixnum.zero?
        assert test_fixnum < test_fixnum + 1
        assert test_fixnum > test_fixnum - 1
        assert_equal 4, test_fixnum.round
        assert_equal 4, test_fixnum.ceil
        assert_equal 1, test_fixnum.modulo(3)
        assert_equal "4", test_fixnum.to_s
        assert_equal 2, test_fixnum / 2
        assert_equal -4, test_fixnum * -1
        assert_equal test_fixnum, (test_fixnum * -1).abs
        assert test_fixnum.even?
        assert !test_fixnum.odd?
        assert (test_fixnum * -1).even?
        assert !(test_fixnum * -1).odd?
        assert_not_nil test_fixnum.hash

        test_bignum = 999999999999999999999999999999
        assert_equal Bignum, test_bignum.class
        assert test_bignum.is_a? Bignum
        assert test_bignum.is_a? Integer
        assert test_bignum < test_bignum + 1
        assert test_bignum > test_bignum - 1
        assert_not_nil test_bignum.hash

        assert Time.now.to_i.is_a?(Integer)
      end
    end

    context "a non-integer" do
      should "not have access to core Integer methods" do
        assert !0.5.integer?
        assert_raise(NoMethodError) { 0.5.even? }
        assert_raise(NoMethodError) { 0.5.times { |i| puts "does not matter" } }

        assert !Time.now.is_a?(Integer)
        assert_raise(NoMethodError) { Time.now.even? }
      end
    end
  end

  context "calling closest_fibonacci_smaller_or_equal_to on a non-integer" do
    should "throw exception" do
      assert_raise(NoMethodError) { 0.5.closest_fibonacci_smaller_or_equal_to }
      assert_raise(NoMethodError) { 4.5.closest_fibonacci_smaller_or_equal_to }
      assert_raise(NoMethodError) { -0.5.closest_fibonacci_smaller_or_equal_to }
      assert_raise(NoMethodError) { "abc".closest_fibonacci_smaller_or_equal_to }
    end
  end

  context "calling closest_fibonacci_smaller_or_equal_to on a negative integer" do
    should "throw exception" do
      assert_raise(RuntimeError) { -1.closest_fibonacci_smaller_or_equal_to }
    end
  end

  context "calling closest_fibonacci_smaller_or_equal_to on a positive integer or zero" do
    should "return the correct value" do
      assert_equal 0, -0.closest_fibonacci_smaller_or_equal_to
      assert_equal 0, 0.closest_fibonacci_smaller_or_equal_to
      assert_equal 1, 1.closest_fibonacci_smaller_or_equal_to
      assert_equal 2, 2.closest_fibonacci_smaller_or_equal_to
      assert_equal 3, 3.closest_fibonacci_smaller_or_equal_to
      assert_equal 3, 3.closest_fibonacci_smaller_or_equal_to
      assert_equal 5, 5.closest_fibonacci_smaller_or_equal_to
      assert_equal 5, 6.closest_fibonacci_smaller_or_equal_to
      assert_equal 5, 7.closest_fibonacci_smaller_or_equal_to
      assert_equal 8, 8.closest_fibonacci_smaller_or_equal_to
      assert_equal 8, 9.closest_fibonacci_smaller_or_equal_to
      assert_equal 8, 10.closest_fibonacci_smaller_or_equal_to
      assert_equal 8, 11.closest_fibonacci_smaller_or_equal_to
      assert_equal 8, 12.closest_fibonacci_smaller_or_equal_to
      assert_equal 13, 13.closest_fibonacci_smaller_or_equal_to
      assert_equal 13, 14.closest_fibonacci_smaller_or_equal_to
      assert_equal 13, 15.closest_fibonacci_smaller_or_equal_to
      assert_equal 13, 15.closest_fibonacci_smaller_or_equal_to
      assert_equal 13, 20.closest_fibonacci_smaller_or_equal_to
      assert_equal 21, 21.closest_fibonacci_smaller_or_equal_to

      test_fixnum = 99999999
      assert test_fixnum.is_a?(Fibonacci)
      assert test_fixnum.is_a?(Fixnum)
      assert_equal 63245986, test_fixnum.closest_fibonacci_smaller_or_equal_to

      test_bignum = 999999999999999999999999999999
      assert test_bignum.is_a?(Fibonacci)
      assert test_bignum.is_a?(Bignum)
      assert_equal 898923707008479989274290850145, test_bignum.closest_fibonacci_smaller_or_equal_to

      assert_not_nil Time.now.to_i.closest_fibonacci_smaller_or_equal_to
    end
  end

end