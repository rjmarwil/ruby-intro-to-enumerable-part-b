def count(words, &block)
  count = 0
  words.each do |word|
    if block.call(word)
      count += 1
    end
  end
  count
end

# ------ code above this line ------

require 'rspec/autorun'

RSpec.describe '#count' do
  it 'returns the count of words that are longer than the specified max' do
    expect(count(['a', 'big', 'black', 'bear', 'is', 'running']) {|word| word.length > 3}).to eq(3)
    expect(count(['a', 'big', 'black', 'bear', 'is', 'running']) {|word| word.length > 2}).to eq(4)
    expect(count(['a', 'big', 'black', 'bear', 'is', 'running']) {|word| word.length > 10}).to eq(0)
  end

  it 'returns 0 for an empty array' do
    expect(count([]) {|word| puts "hi"}).to eq(0)
  end
end
