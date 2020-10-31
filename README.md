# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
### Local Setup
1. Fork and Clone the repo
2. Obtain Google OAuth credentials

  * Visit https://console.developers.google.com/ and create a new project
  * Open up the project and click on OAuth consent screen, choose external, click create, and proceed with the required info
  * Go back to Credentials on the left and click 'Create Credentials' at the top. Choose OAuth client ID
  * You should receive a Client ID and Client secret. These will go in your application.yml file as:

  * `GOOGLE_CLIENT_ID: < your ID>`
  * `GOOGLE_CLIENT_SECRET: < your ID>`
  
* Configuration
    - `bundle install`
    - `rails db:{create,migrate}`
