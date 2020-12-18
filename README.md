# [My Solar Garden](https://solar-garden-fe.herokuapp.com/) - Frontend

![](https://img.shields.io/badge/Rails-5.2.4-informational?style=flat&logo=<LOGO_NAME>&logoColor=white&color=2bbc8a) ![](https://img.shields.io/badge/Ruby-2.5.3-orange) ![](https://img.shields.io/badge/Code-HTML-informational?style=flat&logo=<LOGO_NAME>&logoColor=white&color=2bbc8a) ![](https://travis-ci.com/My-Solar-Garden/front_end_rails.svg?branch=main)

### Overview
My Solar Garden is an impact driven app here to support you in helping to keep our planet thriving.  By signing up with My Solar Garden, you will be able to track your garden's health and, eventually, how much carbon is it offsetting. 

My Solar Garden can give you daily updates as to how much moisture and light it's receiving.  It will also provide innovative ideas on how to keep your garden healthy and thriving to continue to make a positive impact on our environment.

We want to live in balance with the diversity of our environment. It all starts with healthy soil, and that's what we will help you learn how to cultivate. It starts with one person. That person, is you.

:3rd_place_medal:	_3rd place winner at Turing's Demo Competition. [Take a look at our presentation](https://www.youtube.com/watch?v=bh7JHxniJk8&t=1s)._

-----

### Repos
For access to all the repos that make up the Service Oriented Architecture of this application please visit our [origanization page](https://github.com/My-Solar-Garden).

### Live app
https://solar-garden-fe.herokuapp.com/

### Local Setup
- Versions
  - Rails 5.2.4.3
  - Ruby 2.5.3

- Fork and clone the repository and then run the following commands:
  1. `bundle` (if this fails, try to `bundle update` and then retry)
  1. `rails db:create && rails db:migrate`
- Obtain Google OAuth credentials
    * Visit https://console.developers.google.com/ and create a new project
    * Select the project and on the left click OAuth consent screen, choose external, click create, and proceed with the required fields (if a field is not required you can skip it)
    * Click on Credentials on the left then click '+Create Credentials' at the top. Choose OAuth client ID, choose Web application, and under Authorized redirect URIs if you plan on testing Google OAuth with localhost you will want to include:
    * `http://localhost:3000/auth/google_oauth2/callback`
    * Click Create and you should receive a Client ID and Client secret. These will go in your application.yml file as:

    * `GOOGLE_CLIENT_ID: '< your ID >'`
    * `GOOGLE_CLIENT_SECRET: '< your ID >'`

#### Run your own development server:
```
rails s
```
- You should be able to access the app via http://localhost:3000/

### Database creation
  * My Solar Garden's Front End repository does not have a database that holds any sort of information. Any and all information that is depicted on the My Solar Garden FE repo is gained through API connections to the [My Solar Garden BE Repo](https://github.com/My-Solar-Garden/rails_backend). With this being said, My Solar Garden FE Repo uses an empty database for testing purposes.

### How to run the test suite
  * Clone the My Solar Garden FE repo
    * My Solar Garden FE connects to the Back End Repository via the the [Backend Heroku App](https://solar-garden-be.herokuapp.com/)
  * In the terminal while ```CD'd``` into the FE repo, run ```bundle exec rspec```. This will run all of the tests within the FE repository
    
### Learning Goals
  * Consume two or more external APIs
  * Build APIs that return JSON responses
  * Use an external OAuth provider to authenticate users
  * Refactor code for better code organization/readability
  * Utilize a Service-Oriented Architecture with a front-end, a back-end, and at least two microservices
  * Implement a production-quality user interface using Bootstrap or other common CSS styling framework
  * Optimize your application using at least one of the following
    * Database indexing
    * Eager loading
    * Caching
    * Background workers
    * AJAX requests
  * Practice good project management by using project boards, participating in daily stand-ups and team retros
  * Utilize quality workflow practices: small commits, descriptive pull requests, and code reviews
  * Write thorough, understandable documentation

### Contributors
  * Alex Desjardins
    * [GitHub](https://github.com/moosehandlr)
    * [LinkedIn](https://www.linkedin.com/in/alex-desjardins-59297b8b/)
  * Angela Guardia
    * [GitHub](https://github.com/AngelaGuardia)
    * [LinkedIn](https://www.linkedin.com/in/angela-guardia/)
  * Danielle Coleman
    * [GitHub](https://github.com/dcoleman21)
    * [LinkedIn](https://www.linkedin.com/in/danielle-coleman-86ab3b13/)
  * Daniel Lessenden
    * [GitHub](https://github.com/D-Lessenden)
    * [LinkedIn](https://www.linkedin.com/in/lessenden/)
  * Drew Williams
    * [GitHub](https://github.com/drewwilliams5280)
    * [LinkedIn](https://www.linkedin.com/in/drewwilliams5280/)
  * Eric Hale
    * [GitHub](https://github.com/EHale64)
    * [LinkedIn](https://www.linkedin.com/in/eric-hale-656843155/)
  * Hashim Gari
    * [GitHub](https://github.com/hashmaster3k)
    * [LinkedIn](https://www.linkedin.com/in/hashim-gari/)
  * Leah Riffell
    * [GitHub](https://github.com/leahriffell)
    * [LinkedIn](https://www.linkedin.com/in/leah-riffell/)
  * Logan Riffell
    * [GitHub](https://github.com/lkriffell)
    * [LinkedIn](https://www.linkedin.com/in/logan-riffell/)
  * Luke Hunter James-Erickson
    * [GitHub](https://github.com/LHJE)
    * [LinkedIn](https://www.linkedin.com/in/luke-hunter-james-erickson-b65682143/)
  * Nico Rithner 
    * [GitHub](https://github.com/nicorithner)
    * [LinkedIn](https://www.linkedin.com/in/nicorithner/)
  * Norma Lopez 
    * [GitHub](https://github.com/IamNorma)
    * [LinkedIn](https://www.linkedin.com/in/norma-lopez/)
  * Roberto Rodriguez 
    * [GitHub](https://github.com/robertorodriguez12)
    * [LinkedIn](https://www.linkedin.com/in/roberto-j-rodriguez12/)
