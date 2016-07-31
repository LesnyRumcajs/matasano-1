# encoding: UTF-8
def HexXor (str1, str2)
	raise ArgumentError unless str1.length == str2.length

	str1 = str1.scan(/../).map(&:hex)
	str2 = str2.scan(/../).map(&:hex)
	
	xor_result = []
	str1.zip(str2).each do |el1, el2|
		xor_result << ["%02x" % (el1 ^ el2)]
	end

	xor_result.join

	# if (xor_result.length.odd?)
	# 	raise Exception
	# 	em
end
