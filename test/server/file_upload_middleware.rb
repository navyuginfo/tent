class FileUpload
  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)
    
    if request.post? and request.url.match(/fileupload/)
      [200, {"Content-Type"=>'text/html'}, ["file received"]]
    else
      @app.call(env)
    end
    
  end
  
  def each(&block)
  end
end
