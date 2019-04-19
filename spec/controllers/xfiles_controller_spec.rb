require 'rails_helper'

describe XfilesController, :type => :controller do
  describe "Testing for the download Xfile controller action" do
    # it 'check if download xfile renders a flash message' do
    #   @fake_file = double(Xfile, name: "fakie", content:{"blahblah":"a"})
    #   allow(Xfile).to receive(:find).with("1").and_return(@fake_file)
    #   allow(Xfile).to receive(:find).with("1").and_return(@fake_file)
    #   get 'download_xfile', {:id => 1}
    # end
  end

  describe "Testing for the shared properties controller action" do
    it 'check if shared properties renders a view' do
      json_hash = {"posts"=>[{"title"=>"Foobar"}, {"title"=>"Another"}]}
      @fake_file = double(Xfile, name: "fakie", content:json_hash)
      allow(Xfile).to receive(:find).with(1).and_return(@fake_file)
      allow(Xfile).to receive(:get_properties_from_string).with(json_hash).and_return(['prop'])
      get 'shared_props', {:xfile_id => [1]}
      expect(response).to render_template('shared_props')

    end
  end
end
