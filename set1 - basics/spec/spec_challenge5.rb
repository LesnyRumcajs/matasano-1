# encoding: UTF-8
require 'xor_crypt'
describe XorCrypt,'Challenge 5' do
	before do
		@plaintext 				= "Burning 'em, if you ain't quick and nimble\nI go crazy when I hear a cymbal"
		@key 					= "ICE"
		@ciphertext 			= "0b3637272a2b2e63622c2e69692a23693a2a3c6324202d623d63343c2a26226324272765272a282b2f20430a652e2c652a3124333a653e2b2027630c692b20283165286326302e27282f"

	end

	describe "#repeatingKey" do
		context "given correct key" do
			it 'should repeat it to reach the desired length' do
				key = "FOX"
				expect(XorCrypt.repeatingKey(key, 10)).to eq "FOXFOXFOXF"
				expect(XorCrypt.repeatingKey(key, 3)).to eq "FOX"
				expect(XorCrypt.repeatingKey(key, 1)).to eq "F"
			end
		end
		context	"given incorrect key" do
			it 'should raise argument exception' do
				expect{XorCrypt.repeatingKey(nil,3)}.to raise_error(ArgumentError)
				expect{XorCrypt.repeatingKey("",3)}.to raise_error(ArgumentError)
			end
		end
	end

	describe "#encrypt" do
		context "given correct plaintext and correct key" do
			it 'should return correct ciphertext' do
				expect(XorCrypt.encrypt(@plaintext, @key)).to eq @ciphertext
			end
			it 'encrypting with zero should not change the plaintext' do
				expect(XorCrypt.encrypt("FOX","\x00\x00")).to eq "FOX".unpack('H*').join
			end

			it 'dobule encryption should not result in plaintext' do
				hex_ciphertext = XorCrypt.encrypt @plaintext, @key
				ciphertext = [hex_ciphertext].pack('H*')
				expect(XorCrypt.encrypt(ciphertext, @key)).to eq @plaintext.unpack('H*').join
			end
		end

		context "given invalid plaintext or invalid key" do
			it "should raise ArgumentError" do
				expect{XorCrypt.encrypt(nil,"FOX")}.to raise_error(ArgumentError)
				expect{XorCrypt.encrypt("","FOX")}.to raise_error(ArgumentError)
				expect{XorCrypt.encrypt("FOX",nil)}.to raise_error(ArgumentError)
				expect{XorCrypt.encrypt("FOX","")}.to raise_error(ArgumentError)
			end
		end
	end
end