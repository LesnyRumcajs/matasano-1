require 'openssl'

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

	def encryptCBC
	end

	def decryptCBC
	end
end
