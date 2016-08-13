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

	def getMostLikelyHexKey
		@candidates.key getMostLikelyHexPlaintext
	end

	def getnbestHexKeys(n)
		result = Array.new
		@ranking.sort_by{|k,v| v}.last(n).each do |k,v|
			p k
			p v
			p @ranking.key(v)
			result += [@candidates.key(v)]
		end
		p result
		result
	end

	def getBestScore
		@ranking.values.max
	end

	def printRanking
		@ranking.each {|k,v| puts "key: #{[@candidates.key(k)[0,2]].pack('H*')}, val: #{v}" if v > 0}
	end
	def generateCandidates
		(0..255).to_a.each do |item|
			key = ("%02X" % item)*(@ciphertext.length/2)
			@candidates[key] = HexXor(key, @ciphertext)
		end
	end

	def getPrintableCandidates
		@candidates.delete_if do |k,v|
			[v].pack('H*') =~ /[\x01-\x08\x0E-\x1F]/
		end
	end

	def evaluateCandidates (candidates)
		candidates.each do |key, value|
			@ranking[value] = [value].pack('H*').scan(/[ETAOIN SHRDCMLU]/i).size
			# [value].pack('H*').split("").each do |letter|
				# @ranking[value] += CHARACTER_FREQUENCY[letter] if CHARACTER_FREQUENCY[letter]
			# end
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

		@plaintexts.delete_if {|k,v| k.nil? or v.nil?}
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
