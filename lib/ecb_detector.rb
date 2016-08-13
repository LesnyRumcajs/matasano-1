class ECBDetector
	def initialize (contents)
		@data = contents
	end

	def detect(keysize)
		@data.each_with_index do |line,i|
			grouped = line.chars.each_slice(keysize*2).to_a
			if grouped != grouped.uniq
				# p "Detected ECB in line #{i}: #{line}."
				return true
			end
		end

		false
	end
end