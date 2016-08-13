require 'ecb_detector'

describe "Challenge 8" do
	describe "ecb-detector" do
		it "should detect one ciphertext encrypted with cipher with ECB mode" do
			contents = File.read('spec/aes_ecb_hex.txt').lines.map{|v| v.delete "\n"}
			detector = ECBDetector.new(contents)
			expect(detector.detect (16)).to eq true
		end
	end
end
