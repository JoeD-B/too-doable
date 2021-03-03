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
        todo = Todo.create(name: params[:name])
        user = User.find_by(id: session[:user_id])
        user.todos << todo
        erb :'todo/show'
    end
    get '/todo/:id' do
        @todo = Todo.find_by(id: params[:id])
        if !@todo
            redirect '/todo'
        end
        erb :'todo/show'
    end

    get '/todo/:id/edit' do
        @todo = Todo.find_by(id: params[:id])
        if !@todo
            redirect '/todo'
        end
        erb :'todo/edit'
    end
    patch '/todo/:id' do
        #binding.pry
        todo = Todo.find_by(id: params[:id])
        todo.update(name: params[:name])
        erb :'todo/show'
    end
    delete '/todo/:id' do
        todo = Todo.find_by(id: params[:id])
        todo.delete
        
        redirect('/todo')
    end
   
end
