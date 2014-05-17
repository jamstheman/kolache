from Crypto.Cipher import AES
import base64, os
# os is for urandom, which is an accepted producer of randomness that
# is suitable for cryptology.
def encryption(privateInfo):
	#32 bytes = 256 bits
	#16 = 128 bits
	# the block size for cipher obj, can be 16 24 or 32. 16 matches 128 bit.
	BLOCK_SIZE = 16
	# the character used for padding
	# used to ensure that your value is always a multiple of BLOCK_SIZE
	PADDING = '{'
	# function to pad the functions. Lambda
	# is used for abstraction of functions.
	# basically, its a function, and you define it, followed by the param
	# followed by a colon,
	# ex = lambda x: x+5
	pad = lambda s: s + (BLOCK_SIZE - len(s) % BLOCK_SIZE) * PADDING	
	# encrypt with AES, encode with base64
	EncodeAES = lambda c, s: base64.b64encode(c.encrypt(pad(s)))
	# generate a randomized secret key with urandom
	secret = "bananaheadbananaheadbananaheadba"
	print 'passphrase', secret
	# creates the cipher obj using the key
	cipher = AES.new(secret)
	# encodes you private info!
	encoded = EncodeAES(cipher, privateInfo)
	print 'encoded string', encoded

def decryption(encryptedString):
	PADDING = '{'
	DecodeAES = lambda c, e: c.decrypt(base64.b64decode(e)).rstrip(PADDING)
	encryption = encryptedString
	key = "bananaheadbananaheadbananaheadba"
	cipher = AES.new(key)
	decoded = DecodeAES(cipher, encryption)
	return decoded


