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

  describe "Test basic attribute accessors of xfile model" do
    it "assign xfile name" do
      fake_xfile = instance_double("Xfile")
      allow(fake_xfile).to receive(:name).and_return("xfile_name")
      expect(fake_xfile.name).to eq("xfile_name")
    end
    it "assign xfile name" do
      fake_xfile = instance_double("Xfile")
      allow(fake_xfile).to receive(:content).and_return("xfile_name")
      expect(fake_xfile.content).to eq("xfile_name")
    end
  end

end