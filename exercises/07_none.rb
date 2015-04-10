def none?(input, &block)
  word = true
  input.each do |i|
    if block.call(i)
      word = false
    end
  end
  word
end

# ------ code above this line ------

require 'rspec/autorun'

RSpec.describe '#none?' do
  it 'returns false if there are empty strings anywhere in the array' do
    input = ['a', '', 'b']

    expect(none?(input) { |string| string.empty? }).to eq(false)
  end

  it 'returns false if there are nils anywhere in the array' do
    input = ['a', nil, 'b']

    expect(none?(input) { |string| string.nil? }).to eq(false)
  end

  it 'returns true if all values are non-empty' do
    input = ['fa', 'la']

    expect(none?(input) { |string| string.empty? }).to eq(true)
  end

  it 'returns true since none of the values in the array are even' do
    input = [1, 3, 5, 7, 9]

    expect(none?(input) { |number| number.even? }).to eq(true)
  end

  it 'returns false when the array contains an even value and the provided block checks for even values' do
    input = [1, 3, 5, 7, 9, 12]

    expect(none?(input) { |number| number.even? }).to eq(false)
  end

  it 'returns true when given an empty array, regardless of the provided block' do
    expect(none?([])).to eq(true)
  end
end
