# compute all primes up to specified value using the Sieve of Eratosthenes.
# algorithm described here https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes
def primes_to_val(val)
	numbers = (0..val).map{|i| i}
	numbers[1] = 0
	for i in (2..Math.sqrt(val).to_i)
		if numbers[i] > 0
			j = i**2
			while j <= val do
				numbers[j] = 0
				j = j + i
			end
		end
	end
	numbers.select{|val| val != 0}
end

# http://stackoverflow.com/questions/1042717/is-there-a-way-to-find-the-approximate-value-of-the-nth-prime/1069023#1069023
def n_prime_estimate(n)
	return [0,2,3,5,7,11][n] if n < 6
	logn = Math.log(n)
	log2n = Math.log(Math.log(n))
	if n >= 688383
		n*(logn + log2n - 1.0 + (log2n - 2.0)/logn)
	elsif n >= 178974
		n*(logn + log2n - 1.0 + (log2n - 1.95)/logn)
	elsif n >=39017
		n*(logn + log2n - 0.9385)
	else
		n*(logn +log2n)
	end.floor
end

# https://en.wikipedia.org/wiki/Primality_test
def is_prime(n)
	if n <= 1
		return false
	elsif n <= 3
		return true
	elsif n % 2 == 0 or n % 3 == 0
		return false
	end
	i = 5
	while i**2 <= n do
		if n % i == 0 or n % (i + 2) == 0
			return false
		end
		i = i + 6
	end
	return true
end

# return the first n primes. first obtain an estimate that bound the prime from
# above. Then compute all primes less than the estimate and only return n of them
# since more than needed may be within the  determined esitmate.
def n_primes(n)
	prime_esitimate = n_prime_estimate(n)
	primes_to_val(prime_esitimate)[0..n-1]
end

