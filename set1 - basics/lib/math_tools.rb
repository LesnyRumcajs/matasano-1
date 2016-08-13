# encoding: UTF-8
def HexXor (str1, str2)
	raise ArgumentError unless str1.length == str2.length

	(str1.hex ^ str2.hex).to_s(16).rjust(str1.length, '0')
end

def hammingDistance(data1, data2)
	dist = 0
	
	data1 = data1.unpack('B*').join.split("")
	data2 = data2.unpack('B*').join.split("")
  	data1.zip(data2).each {|el1, el2| dist += 1 if el1 != el2 }
  	dist
end
