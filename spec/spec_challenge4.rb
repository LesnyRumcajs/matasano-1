# encoding: UTF-8
require 'xor_breaker'

describe FileXorBreaker, 'Challenge 4' do
	before do
		@ciphertext_file 		=  "spec/xor_ciphertext_good.txt"
		@plaintext 				= "Now that the party is jumping\n"
		@hexPlaintext 			= "4e6f77207468617420746865207061727479206973206a756d70696e670a"

	end

	describe ".getMostLikelyPlaintext" do
		context "given correct ciphertexts file" do
			it 'should correctly compute the plaintext' do
				breaker = FileXorBreaker.new(@ciphertext_file)
				breaker.break (:printable)
				result = breaker.getMostLikelyPlaintext
				expect(result).to eq @plaintext
			end

			it 'should correctly compute the hex plaintext' do
				breaker = FileXorBreaker.new(@ciphertext_file)
				breaker.break (:printable)
				result = breaker.getMostLikelyHexPlaintext
				expect(result).to eq @hexPlaintext
			end			
		end
	end

end