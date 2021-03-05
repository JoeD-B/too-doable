class User < ActiveRecord::Base
    has_many :todos
    has_secure_password

    validates_uniqueness_of(:username)
    
end
