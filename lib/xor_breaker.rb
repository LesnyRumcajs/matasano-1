# encoding: UTF-8
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

	def break (allowed = :printable)
		if allowed == :printable
			evaluateCandidates getPrintableCandidates
		elsif allowed == :all
			evaluateCandidates @candidates
		else
			raise ArgumentError
		end
	end

	def getMostLikelyPlaintext
		[(@ranking.key @ranking.values.max)].pack('H*')
	end

	def getMostLikelyHexPlaintext
		@ranking.key @ranking.values.max
	end

	def getBestScore
		@ranking.values.max
	end

	def generateCandidates
		(0..255).to_a.each do |item|
			key = ("%02X" % item)*(@ciphertext.length/2)
			@candidates[key] = HexXor(key, @ciphertext)
		end
	end

	def getPrintableCandidates
		@candidates.delete_if {|k,v| [v].pack('H*') =~ /[^[:print:]x0A]/}
	end

	def evaluateCandidates (candidates)
		candidates.each do |key, value|
			[value].pack('H*').split("").each do |letter|
				@ranking[value] += CHARACTER_FREQUENCY[letter] if CHARACTER_FREQUENCY[letter]
			end
		end
	end
end

class FileXorBreaker
	def initialize(ciphertext_file)
		@ciphertexts 	= []
		@plaintexts 	= Hash.new(0)
		File.foreach(ciphertext_file).with_index do |line, line_num|
   			@ciphertexts << line.strip
		end
	end

	def break (allowed = :printable)
		@ciphertexts.each do  |ciphertext|
			breaker = XorBreaker.new(ciphertext)
			if breaker.break(allowed).size > 0
				@plaintexts[breaker.getMostLikelyHexPlaintext] = breaker.getBestScore
			end
		end
	end

	def printResults
		@plaintexts.sort_by{|k,v| v}.each {|k,v| p "#{v.round(3)} : #{[k].pack('H*')}"}
	end

	def printHexResults
		@plaintexts.sort_by{|k,v| v}.each {|k,v| p "#{v.round(3)} : #{k}"}
	end

	def getMostLikelyPlaintext
		[@plaintexts.key(@plaintexts.values.max)].pack('H*')
	end

	def getMostLikelyHexPlaintext
		@plaintexts.key(@plaintexts.values.max)
	end
end

# br = XorBreaker.new("467a773263677b71793270607d657c32747d6a3278677f6261327d64776032667a77327e73686b32767d753c")
# br.break
# p br.getMostLikelyPlaintext

# br = FileXorBreaker.new("../spec/xor_ciphertext_good.txt")
# br.break (:all)
# # br.printHexResults
# p br.getMostLikelyPlaintext