
# ------ code above this line ------

require 'rspec/autorun'

RSpec.describe '#reduce' do
  it 'returns single value for a given array and starting value' do
    expect(reduce([1,2,3], 0){|sum, number| sum + number }).to eq(6)
    expect(reduce([5,7,9], 1){|product, number| product * number }).to eq(315)
  end

  it 'returns values that can be arrays' do
    expect(reduce(["big", "brown", "bear"], []){|result, item| result += [item.upcase] }).to eq(["BIG", "BROWN", "BEAR"])
  end

  it 'returns the default value when given an empty array' do
    expect(reduce([], :foo){|sum, number| sum + number }).to eq(:foo)
  end
end
