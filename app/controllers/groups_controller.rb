class GroupsController < ApplicationController

  def group_params
    params.require(:group).permit(:name, :xfile_id)
  end


  def index
    @groups = Group.all
  end

  #Render new template
  def new
    xfile_ids = params[:xfile_id]
    @file_names = []
    xfile_ids.each do |id|
      current_xfile = Xfile.find(id.to_i)
      content = current_xfile.content
      @file_names.append(current_xfile)
    end
    render 'new'

  end

  #To create a new group
  def create
    xfile_ids = params[:xfile_id]
    name = params[:group][:name]
    @group = Group.create!(:name => name)
    xfile_ids.each do |id|
      xfile = Xfile.find(id.to_i)
      @group.xfiles << xfile
    end
    @group.save
    redirect_to groups_path

  end

  #To edit a group: either adding or removing a file.
  def edit
  end

  #To show all the xfiles within a group
  def show
    id = params[:id] # retrieve group ID from URI route
    @group = Group.find_by(:id => id)
    @xfiles = @group.xfiles

  end

  #To update the file, but also not necessary at the moment.
  def update
  end


end
