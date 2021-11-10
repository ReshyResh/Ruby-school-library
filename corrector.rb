class Corrector
  def correct_name(name)
    letters = name.chars
    letters.length > 10 ? letters = letters[0, 10] : letters
    letters.first.upcase!
    letters.join
  end
  def lowercase(str)
    str.downcase
  end
end
