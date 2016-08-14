require 'openssl'
require 'tools_string'

module AESCipher
	module_function
	def encryptECB(plaintext,key, padding: true)
		cipher = OpenSSL::Cipher::AES.new('128-ECB')
		cipher.encrypt
		cipher.key = key

		cipher.padding = 0 if not padding
		cipher.update(plaintext) + cipher.final 
	end

	def decryptECB(ciphertext,key, padding: true)
		cipher = OpenSSL::Cipher::AES.new('128-ECB')
		cipher.decrypt
		cipher.key = key

		cipher.padding=0 if not padding
		cipher.update(ciphertext) + cipher.final
	end


	## The point of challenge 10 is to implement CBC without using OpenSSl
	## So, we have to do it by hand.

	def encryptCBC(plaintext, key, iv, padding: false)
		## split the text into chunks of block size
		block_size = 16
		blocks = plaintext.chars.each_slice(block_size).to_a.map{|v| v.join.to_s}


		ciphertext = String.new
		vector = iv
		blocks.each do |block|
			xor = block^vector
			vector = encryptECB(xor, key, padding: false)
			ciphertext += vector
		end

		ciphertext
	end

	def decryptCBC(ciphertext, key, iv, padding: false)
		## split the text into chunks of block size
		block_size = 16
		blocks = ciphertext.chars.each_slice(block_size).to_a.map{|v| v.join.to_s}


		plaintext = String.new
		vector = iv
		blocks.each do |block|
			decrypted_block = decryptECB(block, key, padding: false)
			plaintext += decrypted_block^vector
			vector = block
		end

		plaintext		
	end
end
