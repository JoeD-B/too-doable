class TodoController < ApplicationController
    get "/todo" do
        @todos = Todo.all
        erb :index
    end

    get "/todo/new" do
        erb :'todo/new_todo'
    end
    
    post "/todo" do
        #binding.pry
        @todo = Todo.create(name: params[:name])
        erb :'todo/show'
    end
    
    
end
