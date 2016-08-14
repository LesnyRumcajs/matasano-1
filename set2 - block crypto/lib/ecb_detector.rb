class ECBDetector
	def initialize (contents)
		@data = contents
	end

	def detect(keysize)
		grouped = @data.chars.each_slice(keysize*2).to_a
		if grouped != grouped.uniq
			# p "Detected ECB in line #{i}: #{line}."
			return true
		end

		false
	end
end