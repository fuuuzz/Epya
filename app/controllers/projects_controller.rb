class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:edit, :update, :destroy, :new, :create]
  before_action :getFollowers, only: [:show, :show_tab]

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  end
  
  #
  # TAB Project#show
  #
  # GET-AJAX /projects/1
  def show_tab
     @project = Project.find(params[:id])
     respond_to do |format|
       format.js
     end
  end
  # GET-AJAX /projects/1
  def actu_tab
    @project = Project.find(params[:id])
    @new = New.new
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
   @users    = User.all
   @project  = Project.new(project_params)
   # Set project author
   @project.user = current_user
   @project.author = @project.user.name                                                                                                                                                                                     
    respond_to do |format|
      if @project.save
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
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
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
  
  # GET /project/1/follow
  # Save current user as follower for the project id that passed in url params
  def follow
    
   @follower = Follower.new
   
   @project = Project.find(params[:id])
   
   @follower.user = current_user
   @follower.project = @project
   
   if @follower.valid? && @project.user.id != current_user.id
     
     respond_to do |format|
       if @follower.save
         format.html { redirect_to @project, notice: 'You follow this project' }
         format.json { head :no_content }
       end
     end
     
   else
     redirect_to @project, notice: 'Sorry but, you already follow this project, or you are the author for this project !'
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :description, :photo, :tags, :author, :collaborators, :followers)
    end
end
