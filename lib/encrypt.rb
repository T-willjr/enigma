require_relative('enigma')

enigma = Enigma.new

message_txt = ARGV.first
encrypt_txt = ARGV[1]
message = File.read(message_txt).strip
enigma.encrypt(message, "02715", "040895")
encrypted_file = File.open(encrypt_txt, "w+") { |file| file.write(enigma.encrypted_message) }

puts "Created '#{encrypt_txt}' with the key #{enigma.key} and date #{enigma.date}"
