require './config/environment'



use Rack::MethodOverride
use UserController
use TodoController
run ApplicationController