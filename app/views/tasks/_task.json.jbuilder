json.extract! task, :id, :title, :description, :priority, :due, :created_at, :updated_at
json.url task_url(task, format: :json)