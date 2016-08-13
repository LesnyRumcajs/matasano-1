require 'math_tools'

module XorCrypt
	module_function
	def repeatingKey(key, len)
		raise ArgumentError if key.nil? or key == ""

		newKey = String.new
		(0..len-1).each {|i| newKey += key[i%key.length]}
		newKey
	end

	def encrypt (plaintext, key)
		raise ArgumentError if plaintext.nil? \
							or key.nil? \
							or plaintext == "" \
							or key == ""

		ext_hex_key = repeatingKey(key, plaintext.length).unpack('H*').join
		hex_plaintext = plaintext.unpack('H*').join

		HexXor(hex_plaintext, ext_hex_key)
	end
end