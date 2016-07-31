require 'xor_breaker'

describe XorBreaker, 'Challenge 3' do
	before do
		@plaintext 		=  "The quick brown fox jumps over the lazy dog."
		@hexPlaintext	= "54686520717569636b2062726f776e20666f78206a756d7073206f76657220746865206c617a7920646f672e"
		@ciphertext 	= "467a773263677b71793270607d657c32747d6a3278677f6261327d64776032667a77327e73686b32767d753c"
		@key 			= "12"
	end

	describe ".break" do
		context "given correct ciphertext" do
			it "should produce 256 candidates" do
				breaker = XorBreaker.new(@ciphertext)
				results = breaker.break
				expect(results.length).to equal 256
			end
		end
	end

	describe ".getMostLikelyPlaintext" do
		context "given correct ciphertext" do
			it 'should correctly compute the plaintext' do
				breaker = XorBreaker.new(@ciphertext)
				breaker.break
				result = breaker.getMostLikelyPlaintext
				expect(result).to eq @plaintext
			end

			it 'should correctly compute the hex plaintext' do
				breaker = XorBreaker.new(@ciphertext)
				breaker.break
				result = breaker.getMostLikelyHexPlaintext
				expect(result).to eq @hexPlaintext
			end			
		end
	end

end