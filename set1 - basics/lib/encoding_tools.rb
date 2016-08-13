require "base64"

def hexstringToBase64 (str)
	Base64.strict_encode64 [str].pack('H*')
end

def base64ToHexString (str)
	Base64.strict_decode64(str).unpack('H*').join
end
