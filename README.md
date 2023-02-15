# CASA LATERITE

## Setting up your work environment

The app currently runs on `ruby 3.2.1` & `nodejs 19.6.0`.

Install Ruby using [rbenv](https://github.com/rbenv/rbenv), or [asdf](https://asdf-vm.com/), or [rvm](https://rvm.io/).

Install NodeJS using [nvm](https://github.com/nvm-sh/nvm), or [asdf-nodejs](https://github.com/asdf-vm/asdf-nodejs)

❗❗❗ Make sure that your local versions are correct:
`$ rbenv install 3.2.1` & `$ nvm install 19.6.0`

Postgresql as our database server: `$ brew install postgresql`

Install Redis, need it for Sidekiq: `$ brew install redis`

Install the right bundler: `gem install bundler -v 2.4.6`

`$ npm install --global yarn`


### To install the application dependencies:

* Ruby: `$ bundle install`
* Javascript: `$ yarn install`


## Rails Database

Create the database, run:
`bundle exec rails db:create`

Run migration:
`bundle exec rails db:schema:load`

Generate data:
`bundle exec rails db:seed`


## Running the app

Start your server:
`bin/dev` this will launch all the processes listed in `Procfile.dev`

Enjoy the headaches 😁


## Sidekiq

Sidekiq is an asynchronous worker based on Redis. We use it to process certain tasks like emailling asynchronously.

To run sidekiq, open a new tab in your terminal and execute:

 ```
 # This command deletes all the pending jobs to prevent Sidekiq from processing hundreds of jobs when starting it.
 rails runner 'Sidekiq::Queue.all.each(&:clear); Sidekiq::RetrySet.new.clear; Sidekiq::ScheduledSet.new.clear; Sidekiq::DeadSet.new.clear'
 bundle exec sidekiq
 ```


## Test accounts:

There a two accounts created during the seed process:

* For admin section:

  url: [http://localhost:7000/admin](http://localhost:7000/admin)

  email: `jsmith@laterite.casa`

  password: `password`
* For clients (accounts) section:

  url: [http://localhost:7000/dashboard](http://localhost:7000/dashboard)

  email: `rrabezafy@account.com`

  password: `password`

These logins are usable in development and on staging.


## Gotchas & Known Issues

### Binding.pry

When running the app with `$ bin/dev` and then try to debug in the CLI after setting a breakpoint, `binding.pry`, in the
code it will not work properly, better to run the app using `$ bin/rails server -p 7000` in that case.
The reason is that `$ bin/dev` uses the *Procfile.dev* which not only runs the rails server but also JS & CSS watcher.

#### Restart services

❗ Might need to launch additional commands for Redis to work:

* `$ brew services restart postgresql`

* `$ brew services restart redis`

❗️ If error: `The asset "application.css" is not present in the asset pipeline.`, run:
`$ yarn build:css --watch`
