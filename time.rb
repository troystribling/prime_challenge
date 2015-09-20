require_relative 'primes'

def time
	start= Time.now
	yield
	puts "#{(1000.0*(Time.now - start)).to_i}ms"
end

time do
	n = ARGV.first.to_i
	puts "invalid length" unless n_primes(n).length == n
end