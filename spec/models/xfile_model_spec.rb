require 'rails_helper'

describe Xfile do
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
