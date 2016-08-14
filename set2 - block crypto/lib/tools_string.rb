class String
	def^(rhs)
		raise ArgumentError if rhs.size != self.size
		self.bytes.zip(rhs.bytes).map { |x,y| (x^y).chr }.join
	end
end