# tent

Widget library using twitter bootstrap for ember.js

## To Build:

We use Rack with Rake-Pipeline to build the assets, so the following will kick off a server:

* bundle install
* bundle exec rackup

Then navigate to 'http://localhost:9292/testpad.html'. 

tent.js will be published to the /dist folder. 

Unit tests may be run at: http://localhost:9292/qunit.html


## Folder Structure:

* /dist: contains the built tent.js 
* /docs: js docs for the library
* /lib: code and assets for tent
* /test: scaffold for testpad.html test page, and unit tests
* /vendor: dependencies for tent
* /bower: dependencies for tent

## Running Tests

Initial Installation:
* Install Node: 'brew install node'
* Install NPM: 'curl https://npmjs.org/install.sh | sudo sh'
* Install Grunt Command Line: 'npm install -g grunt-cli'
* Install all other dependencies: 'sudo npm install'
* Install Karma: 'sudo npm install -g karma'

Watching and executing tests:
Run 'grunt karma-watch-qunit' in a terminal, which will watch for file changes and execute tests in the background.