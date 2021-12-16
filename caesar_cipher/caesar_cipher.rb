def get_character_encrypted(character, position)
  if character.ord.between?(65, 90)
    new_code = character.ord + position
    new_code > 90 ? (64 + (new_code % 90)).chr : new_code.chr
  elsif character.ord.between?(97, 122)
    new_code = character.ord + position
    new_code > 122 ? (96 + (new_code % 122)).chr : new_code.chr
  else
    character
  end
end

def caesar_cipher(plaintext, position)
  plaintext.each_char do |character|
    plaintext.sub!(character, get_character_encrypted(character, position))
  end
end
