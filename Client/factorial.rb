#define class Factorial
class Factorial
	def compute(n)
		tmp = 1
		for i in 1..n
			tmp *= i
		end
		puts(tmp)
	end
end

f = Factorial.new()
f.compute(5)