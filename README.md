# WAQ 2016
Example projects based on Rails 5's ActionCable. It simulates a reservation page of the Tesla Model 3. The project is split between a Rails 5 application (frontend+backend) and an iOS app. Both query a minimalist Rails controller and updates are received in the frontend through an ActionCable websocket.

The Rails backend has a single Sale model that stores ```:name``` and ```:amount```. New Sale entries are broadcasted asynchronously through a SalesChannel and both UI (Rails and iOS) are updated.

This project uses Rails5-Beta3, with Redis for Pub/Sub, and a single Sidekiq process as our background worker.

## Rails
How this project was created:
```
$ rails --version
Rails 5.0.0.beta3
```

```
$ rails new model3
$ rails generate model sale name:string amount:integer
$ rails generate controller sales index
$ rails generate channel sales broadcast
$ rails db:migrate
```

Cross-origin configuration required in development.rb for the iOS app
```
config.action_cable.disable_request_forgery_protection = true
config.action_cable.allowed_request_origins = %w(localhost 127.0.0.1)
```

## iOS
Built with XCode 7.3, connects to a Rails server located at localhost:3000.


# Getting Started
```
$ git clone https://github.com/frobichaud/waq-rails5.git
$ cd waq-rails5/rails
$ bundle install
$ rails db:migrate
$ rails server
```
Visit <a href="http://localhost:3000">http://localhost:3000</a>

