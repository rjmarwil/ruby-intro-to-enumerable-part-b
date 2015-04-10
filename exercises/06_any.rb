def any?(input, &block)
  word = false
  input.each do |i|
    unless block.call(i)
      word = true
    end
  end
  word
end

# ------ code above this line ------

require 'rspec/autorun'

RSpec.describe '#any?' do
  it 'returns true if there are empty strings anywhere in the array' do
    input = ['a', '', 'b']

    expect(any?(input) { |word| word.nil? || word.empty? }).to eq(true)
  end

  it 'returns true if there are nils anywhere in the array' do
    input = ['a', nil, 'b']

    expect(any?(input) { |word| word.nil? || word.empty? }).to eq(true)
  end

  it 'returns false if all values are non-empty' do
    input = ['fa', 'la']

    expect(any?(input) { |word| word.empty? }).to eq(false)
  end

  it 'returns true if any of the numbers in the array are 0' do
    input = [1, 2, 3, 0, 14]

    expect(any?(input) { |number| number == 0 }).to eq(true)
  end

  it 'returns true if any of the numbers in the array are even' do
    input = [1, 2, 3, 0, 14]

    expect(any?(input) { |number| number.even? }).to eq(true)
  end

  it 'returns false when given an empty array' do
    expect(any?([])).to eq(false)
  end
end
