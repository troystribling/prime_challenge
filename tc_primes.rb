require_relative 'primes'
require 'minitest/autorun'


# esimate values were verified by hand calculation and prime numbers used for
# testing were verified on Wolfram Alpha.
describe 'n_prime_estimate' do
	it 'returns the specified prime for n < 6'  do
		 n_prime_estimate(3).must_equal 5
	end
	it 'returns an estimate larger than the prime for 6 <= n < 39017'  do
		estimate = n_prime_estimate(100)
		estimate.must_equal 613
		estimate.must_be :>, 541
	end
	it 'returns an estimate larger than the prime for 39017 <= n < 178974'  do
		estimate = n_prime_estimate(100000)
		estimate.must_equal 1301789
		estimate.must_be :>, 1299709
	end
	it 'returns an estimate larger than the prime for 178974 <= n < 688383'  do
		estimate = n_prime_estimate(200000)
		estimate.must_equal 2750644
		estimate.must_be :>, 2750159
	end
	it 'returns an estimate larger than the prime for n >= 688383'  do
		estimate = n_prime_estimate(1000000)
		estimate.must_equal 15486598
		estimate.must_be :>, 15485863
	end
end

# test if given integer is a prime. Algorithm used is described here
describe 'is_prime' do
	it 'returns false for <= 1' do
		is_prime(1).must_equal false
	end
	it 'returns true for n = 2 or 3' do
		is_prime(2).must_equal true
		is_prime(3).must_equal true
	end
	it 'returns false if n is divisble by 2 or 3' do
		is_prime(100).must_equal false
		is_prime(99).must_equal false
	end
	it 'returns false if n is not prime and not divsible by 2 or 3' do
		is_prime(172762705).must_equal false
	end
	it 'returns true if n is prime' do
		is_prime(15485863).must_equal true
	end
end

# result was manually verified
describe 'primes_to_val' do
	it 'returns all of the primes less than the given value' do
		primes = primes_to_val(30)
		primes.must_equal [2, 3, 5, 7, 11, 13, 17, 19, 23, 29]
	end
end

# result was maually veified
describe 'n_primes' do
	it 'returns the first n primes' do
		primes = n_primes(10)
		primes.must_equal [2, 3, 5, 7, 11, 13, 17, 19, 23, 29]
	end
end