Gem::Specification.new do |s|
  s.name = "tent_widget"
  s.version = '1.0'
  s.authors = ["Raghu Rajah"]
  s.summary = "Widget library using twitter bootstrap for ember.js "
  s.homepage = "https://github.com/PrimeRevenue/tent"
  s.require_paths = ["lib"]
  s.files = Dir["lib/coffeescript/**/*"]+Dir["lib/vendor/**/*.{js,scss}"]
end