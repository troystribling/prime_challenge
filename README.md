# Prime Challenge

The prime challenge requires implementation of an algorithm to determine the the first n prime numbers for arbitrary values of n. The algorithm chosen to find prime numbers is [the sieve of Eratosthenes](https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes). An algorithm to place an upper bound on the n'th prime number is also required. The approximations used here were pieced together from this [post](http://stackoverflow.com/questions/1042717/is-there-a-way-to-find-the-approximate-value-of-the-nth-prime). Details of the implementation and performance will be discussed in following sections.

## Requirements

- ruby 2.2.1
- bundler 1.10.5

## Installation

Running test cases requires installing the minitest gem.

```bash
bundle install
```

## Usage

To tun test cases,

```bash
ruby tc_primes.rb
```

To print table of products of first 10 primes,

```bash
ruby print_first_10_primes.rb
```

Time a run to find the first n primes,

```bash
ruby time.rb n
```

## Algorithm

The prime challenge requires finding the first n prime numbers. The sieve of Eratosthenes computes all of the primes less than a given value. It follows that a method is needed to place an upper bound on the n'th prime number. Estimating the n'th prime number appears to be a dark art. Developed approximations are only valid over intervals of values of n. The approximations used here were pieced together from this [post](http://stackoverflow.com/questions/1042717/is-there-a-way-to-find-the-approximate-value-of-the-nth-prime). Estimates from the top answer and another further down were used to obtain estimates that worked well for values of n ranging 10 to 100,000,000.

## Complexity

All of the computation is spent in the sieve loop. The implementation is fairly simple while estimating the complexity is not,

```ruby
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
```

val is the upper bound estimate of the n'th prime. The potential prime numbers are stored in the numbers array whose values are initialized with the index. As numbers are discovered to be not prime their value in numbers is set to zero. When complete only primes will have nonzero values in numbers. The outer loop will range from 2 up to the square root of the estimated n'th prime value but the inner loop will only be run for values of i which are prime and will range from i**2 up to the estimated value of the n'th prime with an increment of i. It follows that the number of interations of the inner loop is,

```text
I(i) = (val - i**2)/i + 1
```

The total number of inner loop interations will be the sum of I(i) over all prime numbers less than the estimated value go the n'th prime number. 

An inefficiency of the algorithm is that none prime numbers will have multiple updates of the numbers array.


## Performance

The largest value of n tested was 10,000,000. Larger values ran into memory issues which severely degraded performance. The table columns are the number of primes, the algorithm run rime and the total number of iterations of the inner loop. Upon examining the Run Time and Iterations it is seen that the performance scaling with n is slightly worse that linear but much better than quadratic, since as n increases by 10 Run Time and Iterations are increasing by a factor slightly more than 10, as well as increasing, but much less that a factor of 100 which would indicate quadratic scaling.

<table>
  <tr>
    <th>n</th>
    <th>Run Time (ms)</th>
		<th>Iterations</th>
  </tr>
	<tr>
		<td>10</td>
		<td>0</td>
		<td>24</td>
	</tr>
	<tr>
		<td>100</td>
		<td>0</td>
		<td>824</td>
	</tr>
	<tr>
		<td>1,000</td>
		<td>1</td>
		<td>14,895</td>
	</tr>
	<tr>
		<td>10,000</td>
		<td>17</td>
		<td>222,076</td>
	</tr>
	<tr>
		<td>100,000</td>
		<td>208</td>
		<td>2,788,655</td>
	</tr>
	<tr>
		<td>1,000,000</td>
		<td>2,723</td>
		<td>35,823,140</td>
	</tr>
	<tr>
		<td>10,000,000</td>
		<td>30,569</td>
		<td>441,228,090</td>
	</tr>
</table>
