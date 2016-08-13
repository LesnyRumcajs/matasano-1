# encoding: UTF-8
require 'base64'
require 'math_tools'
require 'xor_breaker'
require 'xor_crypt'

class RepeatingXorBreaker
	def initialize(file)
		@data = Base64.strict_decode64 File.read(file).delete("\n")
		@HexData = base64ToHexString File.read(file).delete("\n")
		@key_min = 2
		@key_max = 40
	end

	def computeKeySize
		distances = Hash.new
		(@key_min..@key_max).each do |key_size|
			blocks = @data.scan(/.{#{key_size}}/)
			distance = 0
			(1..blocks.size - 1).step(2).each do |index|
				distance += (hammingDistance blocks[index], blocks[index-1]) / key_size.to_f
			end
			distances[key_size] = distance / blocks.size / 2
		end
		# p "Computed possible key size #{distances.key distances.values.min}"
		@key_size = distances.key distances.values.min
	end

	def solveSingleXor (transposedBlock)
		newkey = String.new
		transposedBlock.each_with_index do |v, i|
			breaker =  XorBreaker.new v
			breaker.break (:printable)
			newkey += [breaker.getMostLikelyHexKey[0,2]].pack('H*')
		end
			# p "Most likely key: #{newkey}"
			newkey = XorCrypt.repeatingKey(newkey, @data.size)
			[XorCrypt.encrypt(@data, newkey)].pack('H*')
	end

	def getTransposedHexDataBlocks
		@HexData.scan(/.{#{@key_size*2}}/).map {|v| v.chars.each_slice(2).to_a}.transpose.map{|v| v.join}
	end	
	def break
		computeKeySize
		solveSingleXor getTransposedHexDataBlocks
	end
end