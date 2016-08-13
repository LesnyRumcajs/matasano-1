require 'encoding_tools'

describe 'Challenge 1' do
	before do
		@hex = "49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d"
		@base64 = "SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t"
	end
	it 'correctly encodes hex string to base64' do
		encoded = hexstringToBase64(@hex)
		expect(encoded).to eq @base64
	end

	it 'correctly decodes base64 to hex string' do
		decoded = base64ToHexString(@base64)
		expect(decoded).to eq @hex
	end
end