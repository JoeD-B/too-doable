class TodoController < ApplicationController
  
    get "/todos" do
        redirect_if_not_logged_in
        @todos = Todo.all
        erb :'todos/index'
    end

    get '/todos/new' do
        redirect_if_not_logged_in
        erb :'todos/new'
    end
    
    post "/todos" do
        #binding.pry
        redirect_if_not_logged_in
       

        todo = current_user.todos.create(params[:todo])
        if todo.valid?
            redirect "todos/#{todo.id}"
        else
            flash[:message] = todo.errors.full_messages
            redirect '/todos/new'
        end
    end

    get '/todos/:id' do
        @todo = Todo.find_by(id: params[:id])
        if !@todo
            redirect '/todos'
        end
        erb :'todos/show'
    end

    get '/todos/:id/edit' do
        @todo = Todo.find_by(id: params[:id])
        if !@todo
            redirect '/todos'
        end
        erb :'todos/edit'
    end
    patch '/todos/:id' do
        #binding.pry
        todo = Todo.find_by(id: params[:id])
       todo.update(name: params[:name])
        erb :'todos/show'
    end
    delete '/todos/:id' do
        redirect_if_not_logged_in
        set_todo
        if check_owner(@todo)
          @todo.delete
          redirect('/todos')
        else
          # set up error message
          erb :'todos/show'
        end
    end
end
