def all?(input, &block)
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

RSpec.describe '#all?' do
  it 'returns true if all the elements are empty' do
    input = ['a', '', 'b']

    expect(all?(input) { |word| word.empty? }).to eq(false)
  end

  it 'returns false if any word is present' do
    input = [nil, '', 'la', nil]

    expect(all?(input) { |word| word.nil? || word.empty? }).to eq(false)
  end

  it 'returns true when given an empty array' do
    expect(all?([])).to eq(true)
  end
end
