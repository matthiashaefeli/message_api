# Message

Message is a Rails Api that receives POST request with params to_number and message.

- create and update Providers.
- Set load balance of each Provider.
- Return all Providers and Messages


## How to set up locally

```
$ git clone https://github.com/matthiashaefeli/travel.git
$ cd travel
$ bundle install
$ yarn
$ rails db:create
$ rails db:migrate
$ rails db:seed
```
 ## Running the server

 ```
 $ rails s
 ```
 
 ## Running test
 
 ```
 $ rspec
 ```
 
 ## Test coverege
 
 /message_api/coverage/index.html#_AllFiles

 ## Deploy to Heroku

```
$ heroku login
$ heroku create api_name
$ git config --list | grep heroku    # verify remote
$ git push heroku master
$ heroku ps:scale web=1   # ensure one dyno is running
$ heroku ps # check dynos
$ heroku run rake db:migrate
$ heroku run rake db:seed
```

## Postman commands

### Send new Message

POST: https://mat-texting-service.herokuapp.com/message

Headers: KEY: Content-Type VALUE: application/json

Body: raw

```
{
    "to_number": "5555555555",
    "message": "Message"
}
```
 The Api will respond with:

 ```
 {
    "id": 1,
    "message_id": "39233f8d-7254-4684-80f5-6619df244493",
    "to_number": "5555555555",
    "message": "Message",
    "status": "pending",
    "provider_id": 1,
    "created_at": "2020-09-19T00:00:00.540Z",
    "updated_at": "2020-09-19T00:00:00.292Z"
}
```

### Update Message status

POST: https://mat-texting-service.herokuapp.com/update_message

Headers: KEY: Content-Type VALUE: application/json

Body: raw

```
{
    "message_id": "39233f8d-7254-4684-80f5-6619df244493",
    "status": "delivered"
}
```

### Search for specific messages with to_number

GET: https://mat-texting-service.herokuapp.com/message

Headers: KEY: Content-Type VALUE: application/json

Body: raw

```
{
    "to_number": "5555555555"
}
```

### Search for specific messages with provider_id

GET: https://mat-texting-service.herokuapp.com/message

Headers: KEY: Content-Type VALUE: application/json

Body: raw

```
{
    "provider_id": 1
}
```

Api will respond with array of objects


### Create new Provider

POST: https://mat-texting-service.herokuapp.com/provider

Headers: KEY: Content-Type VALUE: application/json

Body: raw

```
{
    "name": "Provider",
    "url": "https://provider1",
    "load": "10"
}
```

Api will respond with provider object.

### Get all providers

GET: https://mat-texting-service.herokuapp.com//provider

Api will respond with an array of provider objects

### Update provider

POST: https://mat-texting-service.herokuapp.com/update_provider

Headers: KEY: Content-Type VALUE: application/json

Body: raw

```
{
    "id": 2,
    "active": false
}
```

```
{
    "id": 2,
    "load": 20
}
```

Api will respond with provider object

