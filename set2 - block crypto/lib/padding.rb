module Padding
	module_function
	def addPKCS7 (text, block_size)
		end_size = text.size + block_size - (text.size % block_size)
		text.ljust(end_size, (end_size - text.size).chr)
	end
end