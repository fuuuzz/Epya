class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:edit, :update, :destroy, :new, :create]


  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all
    # @projects.each do |project|
    #   project.tags = Array.new
    #   @project_tag = new
    #   @tag = 
    #   @tag
    #   project.tags.push
    # end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
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
   @project = Project.new(project_params)
   @project.user = current_user                                                                                                                                                                                                       
    respond_to do |format|
      if @project.save
        params[:tag].each do |tag|
          @tag = Tag.new
          @tag.name = tag
          @tag.save
          @project_tags = ProjectTag.new
          @project_tags.project_id = @project.id
          @project_tags.tag_id = @tag.id
          @project_tags.save
        end     
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:name, :description, :photo, :tag => [])
    end

end
