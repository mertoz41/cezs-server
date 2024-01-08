# Cezs App Server

Backend code of the Cezs mobile app which allows instrumentalists to build their portfolios and connect with others through maps and a music library. 

Built on Ruby on Rails, RESTful API currently facilitates authentication and authorization using JSON Web Tokens, user uploads to an AWS S3 bucket, real-time messaging with websockets, admin interfaces to manage the app, and a relational database to store and present related data to clients.

https://www.cezsmusic.com

https://apps.apple.com/us/app/cezs/id6450903389

## Next steps

### CDN (done)

Add Cloudfront between the S3 bucket and clients to serve contents directly to the client instead of redirecting through backend to improve content load time.

### Database indexing

Add non-clustered indexes on models where data is requested based on users search input to increase speed of queries (users, bands, songs, artists).


### Redis

Redis is an in-memory data structure store as a multi-purpose tool that will solve the following problems: 

#### Background jobs

Process videos and thumbnails, and send out emails and notifications asynchronously in the background without blocking the main thread using Sidekiq.

#### Cache
Cache results of methods to prevent repetitive queries into database.
