CONTROLLERS:
    Application_controller: 
        - '/' links to 'views/index.erb'
        - helper functions added
    Tweets_controller: 
        - get '/tweets' gets all tweets and displays them. DONE
        - get '/tweets/new' brings the user to a page to create a new tweet. DONE     
        - post '/tweets' posts a new tweet. DONE    FORM TO CREATE THIS IS IN: views/tweets/new DONE (the repo already had this code)
        - get '/tweets/:id' shows you an individual tweet, based on its id. DONE
        - get '/tweets/:id/edit' brings the user to a page to view/edit an individual tweet. DONE
        - patch 'tweets/:id/edit' allows user to submit an edited tweet. DONE   FORM TO CREATE THIS IS IN: views/tweets/edit DONE (repo already had this code)
        - delete '/tweets/:id/delete' allows you to delete a tweet. DONE    FORM TO CREATE THIS IS IN: views/tweets/show
    Users_controller:
        - get '/signup' shows signup page. If the user is logged in, redirect to user's home page. DONE
        - post '/signup' creates a new user and redirects new user to home page. If a content field is missing, user is redirected to signup. DONE      FORM TO CREATE THIS IS IN: views/users/create
        - get '/login' shows the login page. If the user is logged in, redirect to user's home page. DONE
        - post '/login' posts login info. If username and password match database info, bring the user to their home page. DONE.    FORM TO CREATE THIS IS IN: views/users/login
        - get '/logout' clears the session and redirects user to login page. DONE. For some reason, the repo came with: views/users/logout.erb. I think a button for logging out, in a nav bar will work...

MODELS: 
    Tweet:
        - It belongs to a user and validates the presence of content DONE
    User:
        - It has many tweets and validates the presence of username, email, and password. DONE
        - It also has a secure password. DONE 
        - It also extends to slugifiable.rb under concerns folder, to slugify tweets. DONE

VIEWS:
    Tweets:
        - edit.erb - contains form to edit a post. DONE (repo already had this code)
        - new.erb - mostly done? Repo came with a lot of code... May need to double check once login/signup forms are finalized.
        - show.erb - Needs a DELETE form and to check logic after login.
        - tweets.erb - Check logic for displaying all user's tweets after login.
    Users:
        - create.erb: Insert Form with Username, Email, Password 
        - login.erb: Insert Form with Username, Password 
        - logout.erb: Came with the repo... Again, not sure why it's there... Done?
    index.erb - Home page for Fwitter - can update later, if we want. No tests for this page.
    layout.erb - Includes buttons for all pages. Yield has been turned on for all pages to have this layout.

db:
    Schema:
        "tweets" table:
            t.string "content"
            t.integer "user_id"
            t.datetime "created_at"
            t.datetime "updated_at"

        "users" table:
            t.string "username"
            t.string "email"
            t.string "password_digest"



