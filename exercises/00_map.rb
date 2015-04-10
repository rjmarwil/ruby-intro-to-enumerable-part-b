def map(items, &block)
  a = []
  items.each do |item|
    a << block.call(item)
  end
  a  
end

# ------ code above this line ------

require 'rspec/autorun'

RSpec.describe '#map' do
  it 'returns an Array with all of the words turned to uppercase' do
    expect(map(['foo', 'bar']) { |word| word.upcase }).to eq(['FOO', 'BAR'])
  end

  it 'returns an Array with each of the numbers + 10' do
    expect(map([1,2,3,4]) {|int| int + 10}).to eq([11,12,13,14])
  end

  it 'returns an empty array when given an empty array, regardless of the provided block' do
    expect(map([]) { |foo| foo * 100}).to eq([])
  end
end
