require 'cipher'
require 'base64'


describe "Challenge 10" do
	before do
		@key = "YELLOW SUBMARINE"
		@ciphertext = Base64.strict_decode64 File.read("res/10.txt").delete("\n")
		@plaintext = "I'm back and I'm ringin' the bell \nA rockin' on the mike while the fly girls yell \nIn ecstasy in the back of me \nWell that's my DJ Deshay cuttin' all them Z's \nHittin' hard and the girlies goin' crazy \nVanilla's on the mike, man I'm not lazy. \n\nI'm lettin' my drug kick in \nIt controls my mouth and I begin \nTo just let it flow, let my concepts go \nMy posse's to the side yellin', Go Vanilla Go! \n\nSmooth 'cause that's the way I will be \nAnd if you don't give a damn, then \nWhy you starin' at me \nSo get off 'cause I control the stage \nThere's no dissin' allowed \nI'm in my own phase \nThe girlies sa y they love me and that is ok \nAnd I can dance better than any kid n' play \n\nStage 2 -- Yea the one ya' wanna listen to \nIt's off my head so let the beat play through \nSo I can funk it up and make it sound good \n1-2-3 Yo -- Knock on some wood \nFor good luck, I like my rhymes atrocious \nSupercalafragilisticexpialidocious \nI'm an effect and that you can bet \nI can take a fly girl and make her wet. \n\nI'm like Samson -- Samson to Delilah \nThere's no denyin', You can try to hang \nBut you'll keep tryin' to get my style \nOver and over, practice makes perfect \nBut not if you're a loafer. \n\nYou'll get nowhere, no place, no time, no girls \nSoon -- Oh my God, homebody, you probably eat \nSpaghetti with a spoon! Come on and say it! \n\nVIP. Vanilla Ice yep, yep, I'm comin' hard like a rhino \nIntoxicating so you stagger like a wino \nSo punks stop trying and girl stop cryin' \nVanilla Ice is sellin' and you people are buyin' \n'Cause why the freaks are jockin' like Crazy Glue \nMovin' and groovin' trying to sing along \nAll through the ghetto groovin' this here song \nNow you're amazed by the VIP posse. \n\nSteppin' so hard like a German Nazi \nStartled by the bases hittin' ground \nThere's no trippin' on mine, I'm just gettin' down \nSparkamatic, I'm hangin' tight like a fanatic \nYou trapped me once and I thought that \nYou might have it \nSo step down and lend me your ear \n'89 in my time! You, '90 is my year. \n\nYou're weakenin' fast, YO! and I can tell it \nYour body's gettin' hot, so, so I can smell it \nSo don't be mad and don't be sad \n'Cause the lyrics belong to ICE, You can call me Dad \nYou're pitchin' a fit, so step back and endure \nLet the witch doctor, Ice, do the dance to cure \nSo come up close and don't be square \nYou wanna battle me -- Anytime, anywhere \n\nYou thought that I was weak, Boy, you're dead wrong \nSo come on, everybody and sing this song \n\nSay -- Play that funky music Say, go white boy, go white boy go \nplay that funky music Go white boy, go white boy, go \nLay down and boogie and play that funky music till you die. \n\nPlay that funky music Come on, Come on, let me hear \nPlay that funky music white boy you say it, say it \nPlay that funky music A little louder now \nPlay that funky music, white boy Come on, Come on, Come on \nPlay that funky music \n\x04\x04\x04\x04"
		@iv = "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
	end
	it "should correctly decrypt the ciphertext" do
		expect(AESCipher.decryptCBC(@ciphertext, @key, @iv)).to eq @plaintext
	end

	it "shoud correctly encrypt the ciphertext" do
		expect(AESCipher.encryptCBC(@plaintext, @key, @iv)).to eq @ciphertext
	end
end

##
## Test vectors taken from: http://www.inconteam.com/software-development/41-encryption/55-aes-test-vectors#aes-ecb-128
## They're given without the concept of padding, so for the sake of tests, I'm turning it off
##
describe "AESCipher module" do
	describe "ECB" do
		before do
			@key = ["2b7e151628aed2a6abf7158809cf4f3c"].pack('H*')
			@plaintexts = ["6bc1bee22e409f96e93d7e117393172a", "ae2d8a571e03ac9c9eb76fac45af8e51"].map { |e| [e].pack('H*') }
			@expected_ciphertexts = ["3ad77bb40d7a3660a89ecaf32466ef97", "f5d3d58503b9699de785895a96fdbaaf"].map {|e| [e].pack('H*')}		
		end
		describe "encryptECB" do
			it "should correctly compute test vectors" do
				@plaintexts.zip(@expected_ciphertexts).each do |plaintext, ciphertext|
					expect(AESCipher.encryptECB(plaintext, @key, padding: false)).to eq ciphertext
				end
			end
		end

		describe "decryptECB" do
			it "should correctly compute test vectors" do
				@plaintexts.zip(@expected_ciphertexts).each do |plaintext, ciphertext|
					expect(AESCipher.decryptECB(ciphertext, @key, padding: false)).to eq plaintext
				end
			end
		end
	end
	describe "CBC" do
		before do
			@key = ["2b7e151628aed2a6abf7158809cf4f3c"].pack('H*')
			@iv 	= ["000102030405060708090A0B0C0D0E0F", "7649ABAC8119B246CEE98E9B12E9197D"].map {|e| [e].pack('H*')}
			@plaintexts = ["6bc1bee22e409f96e93d7e117393172a", "ae2d8a571e03ac9c9eb76fac45af8e51"].map { |e| [e].pack('H*') }
			@expected_ciphertexts = ["7649abac8119b246cee98e9b12e9197d", "5086cb9b507219ee95db113a917678b2"].map {|e| [e].pack('H*')}		
		end
		describe "encryptCBC" do
			it "should correctly compute test vectors" do
				@plaintexts.zip(@expected_ciphertexts, @iv).each do |plaintext, ciphertext, iv|
					expect(AESCipher.encryptCBC(plaintext, @key, iv, padding: false)).to eq ciphertext
				end
			end
		end

		describe "decryptCBC" do
			it "should correctly compute test vectors" do
				@plaintexts.zip(@expected_ciphertexts, @iv).each do |plaintext, ciphertext, iv|
					expect(AESCipher.decryptCBC(ciphertext, @key, iv, padding: false)).to eq plaintext
				end
			end
		end
	end	
end
