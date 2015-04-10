def find(input, &block)
  hash = nil
  input.each do |i|
    if block.call(i)
      hash = i
    end
  end
  hash
end

# ------ code above this line ------

require 'rspec/autorun'

RSpec.describe '#find' do
  it 'returns the hash where the value for the id key matches the given id' do
    input = [
      {id: 3, name: 'English'},
      {id: 5, name: 'Spanish'},
      {id: 7, name: 'French'},
    ]

    expect(find(input) { |hsh| hsh[:id] == 5 }).to eq({id: 5, name: 'Spanish'})
  end

  it 'returns nil when given an empty array' do
    expect(find([]) { |hsh| hsh[:id] == 10 }).to eq(nil)
  end

  it 'returns nil when given an id that does not exist in the array' do
    input = [ {id: 3, name: 'English'} ]

    expect(find(input) { |hsh| hsh[:id] == 8 }).to eq(nil)
  end

  it 'works with arbitrary objects and blocks, in this case seeing if Dennis Rodman is a person in our array' do
    class Person
      attr_reader :first_name, :last_name
      def initialize(first_name, last_name)
        @first_name = first_name
        @last_name = last_name
      end
    end
    input = [Person.new("Michael", "Jordan"), Person.new("Scotty", "Pippin"), Person.new("Dennis", "Rodman")]

    expect(find(input) { |person| person.first_name == 'Dennis' && person.last_name == 'Rodman' })
  end
end
