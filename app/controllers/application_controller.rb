class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  #$hostname = request.host_with_port
  #$hostname = "http://0.0.0.0:3000"
  $hostname = "http://billguru.heroku.com"
end
