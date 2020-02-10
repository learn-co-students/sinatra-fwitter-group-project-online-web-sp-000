--User
:username
:email
:has_secure_password
has_many :tweets

--Tweet
:content
:user_id
belongs_to :user

homepage '/'
  if sessions_id == nil
    show login and sign-up options
  else
    show user_homepage

    get '/' do
    if sessions_id.empty?
      redirect to '/login'
    else
      erb '/'
