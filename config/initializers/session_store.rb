# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_prefer-web_session',
  :secret      => '854017a50d613568e14987ef65cf0b75dbcb219794c0de75c0658ae4c3a27beb121ca2b19098b9cb9ed4b35473399eaa910aa568dda80f1f3a0a8528e5730231'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
