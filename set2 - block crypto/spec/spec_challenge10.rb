require 'cipher'

describe "AESCipher module" do
	describe "ECB" do
		before do
			@key = ["2b7e151628aed2a6abf7158809cf4f3c"].pack('H*')
			@plaintexts = ["6bc1bee22e409f96e93d7e117393172a", "ae2d8a571e03ac9c9eb76fac45af8e51"].map { |e| [e].pack('H*') }
			@expected_ciphertexts = ["3ad77bb40d7a3660a89ecaf32466ef97", "f5d3d58503b9699de785895a96fdbaaf"].map {|e| [e].pack('H*')}		
		end
		describe "encryptECB" do
			it "should correctly compute test vectors" do
				@plaintexts.zip(@expected_ciphertexts).each do |plaintext, ciphertext|
					expect(AESCipher.encryptECB(plaintext, @key, padding: false)).to eq ciphertext
				end
			end
		end

		describe "decryptECB" do
			it "should correctly compute test vectors" do
				@plaintexts.zip(@expected_ciphertexts).each do |plaintext, ciphertext|
					expect(AESCipher.decryptECB(ciphertext, @key, padding: false)).to eq plaintext
				end
			end
		end
	end
end
