# Cezs App Server

Backend code of the Cezs mobile app which allows instrumentalists to build their portfolios and connect with others through maps and a music library. 

Built on Ruby on Rails, RESTful API facilitates authentication and authorization using JSON Web Tokens, video uploads to an AWS S3 bucket through background jobs with Sidekiq, real-time messaging with websockets, admin interface to manage the app, and a relational database to store and present complex data to clients.

https://www.cezsmusic.com

https://apps.apple.com/us/app/cezs/id6450903389

# System Design
<img src="https://github.com/mertoz41/cezs-server/assets/61475669/1e3577d4-6fda-40a5-8bd4-bb5f1bcd3c1e" height="600" width="800"/>



## Next improvements
* Add loadbalancer between client and server
* Add cache layer between server and db
