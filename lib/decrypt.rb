require 'pry'
require_relative('enigma')

enigma = Enigma.new

encrypted_txt = ARGV.first
decrypt_txt = ARGV[1]
decrypt_key = ARGV[2]
decrypt_date = ARGV[3]
# binding.pry 
encrypted_message = File.read(encrypted_txt).strip
enigma.decrypt(encrypted_message, decrypt_key, decrypt_date)
encrypted_file = File.open(decrypt_txt, "w+") { |file| file.write(enigma.decrypted_message) }

puts "Created '#{decrypt_txt}' with the key #{enigma.key} and date #{enigma.date}"
