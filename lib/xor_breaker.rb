require 'math_tools'
require 'frequency_hash_en'

class XorBreaker
	def initialize (ciphertext)
		raise ArgumentError unless ciphertext.length.even?
		@ciphertext = ciphertext
		@candidates = Hash.new
		@ranking 	= Hash.new(0)

		generateCandidates
	end

	def break
		evaluateCandidates
	end

	def getMostLikelyPlaintext
		[(@ranking.key @ranking.values.max)].pack('H*')
	end

	def getMostLikelyHexPlaintext
		@ranking.key @ranking.values.max
	end

	private

	def generateCandidates
		(0..255).to_a.each do |item|
			key = ("%02X" % item)*(@ciphertext.length/2)
			@candidates[key] = HexXor(key, @ciphertext)
		end
	end

	def getPrintableCandidates
		@candidates.each do |key, value|
			candidate = [value].pack('H*')
			candidate unless candidate =~ /[^[:print:]]/
		end
	end

	def evaluateCandidates
		@candidates.each do |key, value|
			[value].pack('H*').split("").each do |letter|
				@ranking[value] += CHARACTER_FREQUENCY[letter] if CHARACTER_FREQUENCY[letter]
			end
		end
	end
end
