require 'cipher'
require 'ecb_detector'

describe 'Challenge 11' do
	describe 'generateKey' do
	  it 'should return key of proper length' do
	  	expect(AESCipher.generateKey.size).to eq 16
	  end
	  it 'keys should at least try to be random' do
	  	key1 = AESCipher.generateKey
	  	key2 = AESCipher.generateKey

	  	expect(key1 != key2).to eq true
	  end
	end

	describe 'encryption_oracle' do
	  it 'should return a proper ciphertext' do
	  	plaintext = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
	  	100.times do
	  		ciphertext, mode = AESCipher.encryption_oracle plaintext
	  		detector = ECBDetector.new(ciphertext)
	  		detected_ECB = detector.detect(16)

	  		if mode == 'ECB'
	  			expect(detected_ECB).to eq true
	  		else
	  			expect(detected_ECB).to eq false
	  		end
	  	end

	  end
	end
  
end