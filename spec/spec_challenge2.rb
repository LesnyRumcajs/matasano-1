require 'math_tools'

describe 'Challenge 2' do
	before do
		@first_string 	= "1c0111001f010100061a024b53535009181c"
		@second_string 	= "686974207468652062756c6c277320657965"
		@xor_string		= "746865206b696420646f6e277420706c6179"
	end
	it 'correctly produces xor result' do
		result = HexXor @first_string, @second_string
		expect(result).to eq @xor_string
	end

	it 'raises an exception when strings are not of equal length' do
		expect{HexXor(@first_string, "12")}.to raise_error(ArgumentError)
	end
end