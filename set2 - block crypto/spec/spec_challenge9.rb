require 'padding'

describe "Challenge 9" do
	describe "PKCS#7 padding" do
		it "should correctly add PKCS#7 padding" do
			expect(Padding.addPKCS7("YELLOW SUBMARINE", 20)).to eq "YELLOW SUBMARINE\x04\x04\x04\x04"
			expect(Padding.addPKCS7("YELLOW SUBMARINEYELLOW SUBMARINE", 20)).to eq "YELLOW SUBMARINEYELLOW SUBMARINE\x08\x08\x08\x08\x08\x08\x08\x08"
		end

		it "should add a whole block if text length is of block size" do
			expect(Padding.addPKCS7("YELLOW SUBMARINE", 16)).to eq "YELLOW SUBMARINE\x10\x10\x10\x10\x10\x10\x10\x10\x10\x10\x10\x10\x10\x10\x10\x10"
		end
	end
end
