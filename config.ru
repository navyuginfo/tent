require 'bundler/setup'
require 'rake-pipeline'
require 'rake-pipeline/middleware'

require './test/server/file_upload_middleware'

class NoCache
  def initialize(app)
    @app = app
  end

  def call(env)
    @app.call(env).tap do |status, headers, body|
      headers["Cache-Control"] = "no-store"
    end
  end
end

use NoCache
use FileUpload
use Rake::Pipeline::Middleware, "Assetfile"
run Rack::Directory.new('public')
