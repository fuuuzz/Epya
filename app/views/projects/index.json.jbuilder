json.array!(@projects) do |project|
  json.extract! project, :id, :name, :description, :photo, :tags, :author, :collaborators, :followers
  json.url project_url(project, format: :json)
end
