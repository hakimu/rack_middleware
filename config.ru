require 'json'
require 'newrelic_rpm'

class FirstMiddleware

	def initialize(app)
	  @app = app
	 end

	 def call(env)
	   status, header, body = @app.call(env)
	   reverse_body = body.map {|x| x.reverse}
	 	 [status, header, reverse_body]
	 end

end

class SecondMiddleware

	def initialize(app)
	  @app = app
	end

	def call(env)
    status, header, body = @app.call(env)
    upcase_body = body.map {|x| x.upcase}
    [status, header, upcase_body]
	end 

end


class Hello
  def self.call(env)
    [200,{"Content-Type"=>"text/plain"},["Hello!!!!!!!"]]
   end
end

use FirstMiddleware
use SecondMiddleware
run Hello

