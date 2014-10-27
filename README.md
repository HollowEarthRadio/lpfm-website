lpfm-website
============

Simple community radio website infrastructure (programs, djs, now playing, podcasts, etc)

To run:
============
bundle exec foreman start -p 3000

You must have an .env file that specifies  your S3_KEY / S3_SECRET

If you wish to use the Facebook Events script, set FACEBOOK_APP_ID and FACEBOOK_APP_SECRET in your .env file.