def HexXor (str1, str2)
	raise ArgumentError unless str1.length == str2.length

	str1 = str1.scan(/../).map(&:hex)
	str2 = str2.scan(/../).map(&:hex)
	
	xor_result = []
	str1.zip(str2).each do |el1, el2|
		xor_result += [(el1 ^ el2).to_s(16)]
	end

	xor_result.join
end
