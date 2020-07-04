# Google Check

Simple script to check google access with `GOOGLE_APPLICATION_CREDENTIALS`.

## Usage

Export the `GOOGLE_APPLICATION_CREDENTIALS`.

    export GOOGLE_APPLICATION_CREDENTIALS=REPLACE_ME

The GOOGLE_APPLICATION_CREDENTIALS should be a path to the JSON file with the credentials key.

Make sure you run `source ~/.bashrc` or open a new terminal. Then run:

    bundle install
    ruby google_check.rb

## Example

Success looks like this:

    $ bundle exec ruby google_check.rb
    Listing gcs buckets as a test
    my-gcs-bucket
    Successfully connected to Google API with your GOOGLE_APPLICATION_CREDENTIALS
    $

Failure looks like this:

    $ bundle exec ruby google_check.rb
    client.rb:1039:in `fetch_access_token': Authorization failed.  Server message: (Signet::AuthorizationError)
    {"error":"invalid_grant","error_description":"Invalid grant: account not found"}
