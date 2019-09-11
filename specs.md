ApplicationController
  Homepage
    loads the homepage
  Signup Page
    loads the signup page
    signup directs user to twitter index (FAILED - 1)
    does not let a user sign up without a username
    does not let a user sign up without an email
    does not let a user sign up without a password
    does not let a logged in user view the signup page (FAILED - 2)
  login
    loads the login page
    loads the tweets index after login (FAILED - 3)
    does not let user view login page if already logged in (FAILED - 4)
  logout
    lets a user logout if they are already logged in and redirects to the login page
    redirects a user to the index page if the user tries to access /logout while not logged in
    redirects a user to the login route if a user tries to access /tweets route if user not logged in
    loads /tweets if user is logged in (FAILED - 5)
  user show page
    shows all a single users tweets (FAILED - 6)
  index action
    logged in
      lets a user view the tweets index if logged in (FAILED - 7)
    logged out
      does not let a user view the tweets index if not logged in
  new action
    logged in
      lets user view new tweet form if logged in (FAILED - 8)
      lets user create a tweet if they are logged in (FAILED - 9)
      does not let a user tweet from another user (FAILED - 10)
      does not let a user create a blank tweet (FAILED - 11)
    logged out
      does not let user view new tweet form if not logged in (FAILED - 12)
  show action
    logged in
      displays a single tweet (FAILED - 13)
    logged out
      does not let a user view a tweet (FAILED - 14)
  edit action
    logged in
      lets a user view tweet edit form if they are logged in (FAILED - 15)
      does not let a user edit a tweet they did not create (FAILED - 16)
      lets a user edit their own tweet if they are logged in (FAILED - 17)
      does not let a user edit a text with blank content (FAILED - 18)
    logged out
      does not load -- requests user to login (FAILED - 19)
  delete action
    logged in
      lets a user delete their own tweet if they are logged in (FAILED - 20)
      does not let a user delete a tweet they did not create (FAILED - 21)
    logged out
      does not load let user delete a tweet if not logged in (FAILED - 22)

User
  can slug the username
  can find a user based on the slug
  has a secure password
