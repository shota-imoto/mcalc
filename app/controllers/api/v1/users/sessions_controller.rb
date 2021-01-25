class Api::V1::Users::SessionsController < Devise::SessionsController
  protect_from_forgery :except => [:create]

  def create
    puts "routing is ok"
  end
end
