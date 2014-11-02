class WelcomeController < ApplicationController
  layout "welcome_layout"
  
  def hello
    @best_projects = Project.order(followers: :desc).limit(3)
    @tags_footer = Tag.all.limit(5)
  end

end
