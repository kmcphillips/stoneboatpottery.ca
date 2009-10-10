# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_stoneboat_session',
  :secret      => '951c77e8eea9dce24c20ecbf34326510da79fe900b46a18f434d86bcd6066741cce14e71ced116cb0b91df692d31a7d905e0c9442ebbcc93aa5f2c21b2e07e85'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
