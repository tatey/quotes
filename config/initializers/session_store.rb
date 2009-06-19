# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_quotes_session',
  :secret      => '7a4486d641499097cb81d10be86d120f6bd4af0a581e8201b45d9c7e31d6dc7666c73d3d553567e69876804399fe976c0ea537e5d060d6e4a4c4def0e411c06c'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
