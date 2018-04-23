# Test-drivenCode for checking if two words are anagrams
# Inspired by https://twitter.com/fermatslibrary/status/988399621402656773


require 'test/unit'
require 'prime'
require 'pry'

class TestForAnagram < Test::Unit::TestCase
  def test_mapper_for_single_characters
    assert_equal 2, Mapper.new("word").mapped_value("a")
    assert_equal 2, Mapper.new("word").mapped_value("A")

    assert_equal 11, Mapper.new("word").mapped_value("e")
    assert_equal 11, Mapper.new("word").mapped_value("E")

    assert_equal 47, Mapper.new("word").mapped_value("o")
    assert_equal 47, Mapper.new("word").mapped_value("O")

    assert_equal 101, Mapper.new("word").mapped_value("z")
    assert_equal 101, Mapper.new("word").mapped_value("Z")
  end

  def test_mapper_for_small_words
    assert_equal 4, Mapper.new("Aa").value
    assert_equal 8, Mapper.new("Aaa").value
    assert_equal 16, Mapper.new("Aaaa").value
  end

  def test_two_words_for_anagram
    assert_equal true, Anagram.new("Doe", "Eod").match
    assert_equal false, Anagram.new("deed", "dead").match
    assert_equal true, Anagram.new("A decimal point", "I'm a dot in place").match
  end
end

class Anagram
  attr_reader :first, :second
  def initialize(first, second)
    @first = first
    @second = second
  end

  def match
    Mapper.new(first).value == Mapper.new(second).value
  end
end

# Takes a word, maps each letter to a prime number, and computes the product
class Mapper
  attr_reader :word
  def initialize(word)
    @word = word
  end

  def value
    product = 1
    word.scan(/\w/).each do |letter|
      product = product * mapped_value(letter)
    end
    product
  end

  def mapped_value(letter)
    primes = Prime.first(26)
    primes[letter.downcase.ord - "a".ord]
  end
end
