# encoding: UTF-8
require 'xor_breaker'

describe FileXorBreaker, 'Challenge 5' do
	before do
		@ciphertext_file 		=  "spec/xor_ciphertext_good.txt"
		@plaintext 				= "The quick brown fox jumps over the lazy dog."
		@hexPlaintext 			= "54686520717569636b2062726f776e20666f78206a756d7073206f76657220746865206c617a7920646f672e"

	end

	describe ".getMostLikelyPlaintext" do
		context "given correct ciphertexts file" do
			it 'should correctly compute the plaintext' do
				breaker = FileXorBreaker.new(@ciphertext_file)
				breaker.break (:all)
				result = breaker.getMostLikelyPlaintext
				expect(result).to eq @plaintext
			end

			it 'should correctly compute the hex plaintext' do
				breaker = FileXorBreaker.new(@ciphertext_file)
				breaker.break (:all)
				result = breaker.getMostLikelyHexPlaintext
				expect(result).to eq @hexPlaintext
			end			
		end
	end

end