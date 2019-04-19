class XfilesController < ApplicationController

  require 'crack' # XML and JSON parsingrequire 'crack/json' # Only JSON parsing
  require 'crack/xml' # Only XML parsing
  require 'json'

  def xfile_params
    params.require(:xfile).permit(:name, :content, :property, :value)
  end

  #To show the data fields and their relationships in a data file.
  def show
    id = params[:id] # retrieve movie ID from URI route
    @xfile = Xfile.find(id) # look up movie by unique ID
    @content = eval(@xfile.content)
    @properties = Xfile.get_properties(@content)

  end

  #To show the list of files uploaded to the application.
  def index
    @xfiles = Xfile.all
  end

  # default: render 'new' template
  def new
  end


  #To create the file and store it into our database.
  def create
    @content = params[:content]
    if @content.nil?
      flash[:notice] = "Please attach a valid file"
      redirect_to new_xfile_path
    else
      params[:content].each do |file|
        @xfile = file.read
        @name = file.original_filename
        @extension = @name.split('.').last
        if @extension == "json"
          @data = Crack::JSON.parse(@xfile)
          @xfile = Xfile.create!(xfile_params) do |xfile|
            xfile.content = @data
            if xfile.name.empty?
              xfile.name = @name
            end
          end
          flash[:notice] = "#{@xfile.name} was successfully created."
        elsif @extension == "xml"
          @data = Crack::XML.parse(@xfile)
          @xfile = Xfile.create!(xfile_params) do |xfile|
            xfile.content = @data
            if xfile.name.empty?
              xfile.name = @name
            end
          end
          flash[:notice] = "#{@xfile.name} was successfully created."
        else
          flash[:notice] = "Incompatible file type, please attach a valid file"
          redirect_to new_xfile_path and return
        end
      end
      redirect_to xfiles_path
    end
  end

  #To edit the file, but not really necessary at the moment.
  def edit
    params[:property]
  end

  def edit_post
    id = params[:id] # retrieve movie ID from URI route
    @xfile = Xfile.find(id) # look up movie by unique ID
    data = @xfile.content
    data = eval(data)
    key = params[:property]
    value = params[:value]
    data[key] = value
    @xfile = Xfile.create!(name: @xfile.name, content: data)
    redirect_to xfiles_path
  end

  #To update the file, but also not necessary at the moment.
  def update
  end

  def shared_files
    prop = params[:prop]
    @xfiles = Xfile.where("content like ?", "%\"#{prop}\"%")
    render 'shared_files'
  end

  def shared_props
    xfile_ids = params[:xfile_id]
    if xfile_ids.nil?
      redirect_to xfiles_path
    else
      prop_sets = []
      xfile_ids.each do |id|
        current_xfile = Xfile.find(id.to_i)
        content = current_xfile.content
        properties = Xfile.get_properties_from_string(content)
        prop_sets.push(properties)
      end
      @shared_set = prop_sets[0]
      prop_sets.each do |set|
        @shared_set = @shared_set & set
      end
      render 'shared_props'
    end
  end

  def download_xfile
    id = params[:id]
    @xfile = Xfile.find(id)
    content = @xfile.content
    # f = File.new("#{Rails.root}/app/assets/docs/#{@xfile.name}.json", "w+")
    # f.write(eval(@xfile.content).to_json)
    # f.close
    data = eval(@xfile.content).to_json
    send_data data, :filename => "#{@xfile.name}.json"
    # send_file "#{Rails.root}/app/assets/docs/#{@xfile.name}.json", type: "application/json", x_sendfile: true
    flash[:notice] = "#{@xfile.name} was successfully downloaded."
  end

  #To delete the file from database.
  def destroy
    @xfile = Xfile.find(params[:id])
    @xfile.destroy
    flash[:notice] = "File '#{@xfile.name}' deleted."
    redirect_to xfiles_path
  end

end
