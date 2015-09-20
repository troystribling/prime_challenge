require_relative 'primes'

primes = n_primes(10)

puts primes.map{|n| '%5d|' % n}.unshift('%6s' % '').join('')
primes.each do |i|
	products = primes.map{|j| j*i}
	puts products.unshift(i).map{|n| '%5d|' % n}.join('')
end