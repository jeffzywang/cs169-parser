require 'rails_helper'
require 'spec_helper'

describe Xfile do
  fixtures :xfiles
  describe 'get properties for json format' do
    it 'gets the right properties' do
      content = Crack::JSON.parse(xfiles(:json1).content)
      expect(Xfile.get_properties(content)).to eq(['a'])
    end

    it 'returns empty array if no properties in json' do
      content = Crack::JSON.parse(xfiles(:empty).content)
      expect(Xfile.get_properties(content)).to eq([])
    end

    it 'returns right properties with simple nested json' do
      content = Crack::JSON.parse(xfiles(:simple_nested).content)
      expect(Xfile.get_properties(content)).to eq(['a', 'b'])
    end
  end



end