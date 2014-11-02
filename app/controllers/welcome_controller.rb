class WelcomeController < ApplicationController
  layout "welcome_layout"
  
  def hello
    @best_projects = Project.order(followers: :desc).limit(3)
    @tags_footer = Tag.all.limit(5)
    @project_number = Project.count
    @user_number = User.count
    @follower_number = Follower.count
    @collaborator_number = Collaborator.count
  end

end
