class TagsController < ApplicationController
  before_action :set_tag, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:edit, :update, :destroy, :new, :create]

  # GET /tags
  # GET /tags.json
  def index
    @tags = Tag.all
  end

  # GET /tags/1
  # GET /tags/1.json
  # Get all projects that match with the current tag
  # @return void
  def show
    @projects = Array.new
    @projects_tag = ProjectTag.where(tag_id: params[:id])
    if @projects_tag.any?
      @projects_tag.each do |project_tag| 
        @projects.push(Project.find_by_id(project_tag.project_id))
      end
    end
  end

  # GET /tags/new
  def new
    @tag = Tag.new
    @users    = User.all
  end

  # GET /tags/1/edit
  def edit
    @users    = User.all
  end

  # POST /tags
  # POST /tags.json
  def create
    @tag = Tag.new(tag_params)
    @user_tags = UserTags.new
    respond_to do |format|
      if @tag.save
        @user_tags.user = current_user
        @user_tags.tag = @tag
        if @user_tags.save
          format.html { redirect_to @tag, notice: 'Tag was successfully created.' }
          format.json { render :show, status: :created, location: @tag }
          else
          format.html { render :new }
          format.json { render json: @tag.errors, status: :unprocessable_entity }
        end
      else
        format.html { render :new }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tags/1
  # PATCH/PUT /tags/1.json
  def update
    respond_to do |format|
      if @tag.update(tag_params)
        format.html { redirect_to @tag, notice: 'Tag was successfully updated.' }
        format.json { render :show, status: :ok, location: @tag }
      else
        format.html { render :edit }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tags/1
  # DELETE /tags/1.json
  def destroy
    @tag.destroy
    respond_to do |format|
      format.html { redirect_to tags_url, notice: 'Tag was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  # SEARCH
  def search
    @resultTag = Array.new
    @tagSearch = Tag.find_by(name: params[:searchTag])
    if @tagSearch.nil?
    else
      @projects_tag = ProjectTag.where(tag_id: @tagSearch_id)
      if @projects_tag.any?
        @projects_tag.each do |project_tag|
          @resultTag.push(Project.find_by_id(project_tag.project_id))
        end
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tag
      @tag = Tag.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tag_params
      params.require(:tag).permit(:name)
    end


end