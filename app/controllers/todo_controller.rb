class TodoController < ApplicationController
  
    get "/todos" do
        redirect_if_not_logged_in
        @todos = current_user.todos#Todo.all(use this to access all users items)
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
        redirect_if_not_logged_in
        set_todo
        redirect_if_not_owner(@todo)
        erb :'todos/edit'
    end
    

    patch '/todos/:id' do
        redirect_if_not_logged_in
        set_todo
        if check_owner(@todo)
            @todo.update(params[:todo])
        end
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
