class WelcomeController < ApplicationController
  def hello
    @best_projects = Project.order(followers: :desc).limit(3)
  end

end
