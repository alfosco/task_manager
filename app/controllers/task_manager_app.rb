require_relative '../models/task.rb'

class TaskManagerApp < Sinatra::Base
  set :root, File.expand_path("..", __dir__) #ids base level of application; sets up a path to views directory
  set :method_override, true # this allows us to use _method in the form

  get '/' do
    erb :dashboard
  end

  get '/tasks' do
    @tasks = Task.all
    erb :index
  end

  get '/tasks/new' do
    erb :new
  end

  post '/tasks' do
    task = Task.new(params[:task])
    task.save
    redirect '/tasks'
  end

  get '/tasks/:id' do
    @task = Task.find(params[:id])
    erb :show
  end

  get '/tasks/:id/edit' do
    @task = Task.find(params[:id])
    erb :edit
  end

  put '/tasks/:id' do |id|
    Task.update(id.to_i, params[:task])
    redirect "/task/#{id}"
  end

  delete '/tasks/:id' do |id|
    Task.destroy(id.to_i)
    redirect '/tasks'
  end
end

# task_manager_questions

# 1. Define CRUD.
# -CRUD is an acronym that stands for Create, Read, Update, Delete.
# 2. Why do we use set method_override: true?
# -HTML does not allow the use of <em>method='put'</em> in a form tag. By using the given code snippet you can pass it as a hidden value which gives our controller the information it needs to route the request correctly.
# 3. Explain the difference between value and name in this line: <input type='text' name='task[title]' value="<%= @task.title %>"/>.
# -Value is the result of the instance variable <em>task</em> with the method <em>title</em> called on it. Name looks like it's equal to a hash named <em>task</em>, and task is returning the value that <em>title</em> points to.
# 4. What are params? Where do they come from?
# -Params is a hash that is storing our tasks.
# 5. Check out your routes. Why do we need two routes each for creating a new Task and editing an existing Task?
# -They each need a route to the controller for the link that someone selects, and a route to the  corresponding view that will be rendered when they hit the new route.