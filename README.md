# Marvel Comics Explorer
![alt text](https://wallpapercave.com/wp/wp1829344.jpg)
##### Prerequisites

The setups steps expect following tools installed on the system.

- Git
- Ruby 3.0.1
- Rails 6.1.4

##### 1. Clone the repository and cd into it:

        $ git clone https://github.com/valterfernandesdev/marvel_comics_explorer.git
        $ cd marvel_comics_explorer
##### 2. Create database.yml file

Copy the sample database.yml file and edit the database configuration as required.

        marvel_comics_explorer$ cp config/database.yml.sample config/database.yml

##### 3. Create and setup the database

Run the following commands to create and setup the database.

        marvel_comics_explorer$ rails db:create
        marvel_comics_explorer$ rails db:setup
##### 4. Start the Rails server

You can start the rails server using the command given below.


        marvel_comics_explorer$ rails s

And now you can visit the site with the URL http://localhost:3000
        
### Tests (RSpec)

1. Prepare your db to run the tests:

        marvel_comics_explorer$ rails db:test:prepare

2. Run the tests:

        marvel_comics_explorer$ bundle exec rspec

3. Now you can see also the coverage of the project by opening:

        ./coverage/index.html
