class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:edit, :update, :destroy, :new, :create]
  before_action :getFollowers, only: [:show, :show_project_tab]


  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  end
  
  # GET-AJAX /projects/1
  def show_project_tab
     @project = Project.find(params[:id])
     respond_to do |format|
       format.js
     end
  end
  
  # GET-AJAX /projects/1
  def news_tab
    @project = Project.find(params[:id])
    @new = New.new()
    @news = New.where(project_id: params[:id])
    respond_to do | format |  
        format.js
    end
  end
  
  # GET-AJAX /projects/1
  def comment_tab
    @project = Project.find(params[:id])
    @comment = Comment.new
    @comments = Comment.where(project_id: params[:id])
    respond_to do | format |  
        format.js
    end
  end

  # GET /projects/new
  def new
    @project  = Project.new
    @users    = User.all
  end

  # GET /projects/1/edit
  def edit
    @users    = User.all
  end

  # POST /projects
  # POST /projects.json
  def create
   @project       = Project.new(project_params)
   @project.user  = current_user   
   @project.photo = Project.imgupload(params[:project][:photo])                                                                                                                                                                                              
   @users         = User.all
   # Set project author
   @project.author  = @project.user.name
    #Response   
    respond_to do |format|
      if @project.save
        save_tag_for_project(@project)
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end                                                                                                                                                                       
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        save_tag_for_project(@project)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  # GET-AJAX /project/1/follow
  # Save current user as follower for the project id that passed in url params
  def follow 
   @follower = Follower.new
   @project = Project.find(params[:id])
   @follower.user = current_user
   @follower.project = @project
   if @follower.valid? && @project.user.id != current_user.id
     @follower.save
     getFollowers
     set_project
     respond_to do |format|
       format.js
     end
    end
  end

  # GET-AJAX
  def unfollow
    @follower = Follower.find_by(project_id: params[:id], user_id: current_user.id)
    @follower.destroy
    getFollowers
    set_project
    respond_to do |format|
      format.js
    end
  end
  
  # GET-AJAX
  # Destroy association entry between tag param and project param
  # select current project for ajax response
  # @see project/destroy_tag.js.erb
  # @return void
  # @param params[:id] project id, params[:tag] tag id
  def destroy_tag
    @project = Project.find_by_id(params[:id])
    @project_tag = ProjectTag.find_by(project_id: params[:id], tag_id: params[:tag])
    if @project_tag.destroy
      respond_to do |format|
        format.js
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end
    
    # Get users who follow the project id that passed in request param
    def getFollowers
      @followers_project = Follower.where(project_id: params[:id])
      @followers = Array.new
      @followers_project.each do |f|
        user = User.find(f.user_id)
        @followers.push user
      end
    end
    
    def save_tag_for_project(project)
      if params[:tag]
        params[:tag].each do |tag|
          @tag = Tag.new()
          @tag.name = tag
          @tagExist = Tag.find_by(name: tag)
          if @tagExist
            @tagTest = ProjectTag.find_by(project_id: project.id, tag_id: @tagExist)
            if @tagTest
            else
              @project_tags = ProjectTag.new
              @project_tags.project_id = project.id
              @project_tags.tag_id = @tagExist.id
              @project_tags.save
            end 
          else
           if @tag.save
            @project_tags = ProjectTag.new
            @project_tags.project_id = project.id
            @project_tags.tag_id = @tag.id
            @project_tags.save
            end
          end
        end
      end
    end

    def project_params
      params.require(:project).permit(:name, :description, :photo, :tag => [])
    end

end
