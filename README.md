
# README

## Offering Tree Coding Challenge

### Setup:

 1. Run on console `rails db:create`, you only need to run this step if you don't have a *development.sqlite3* database yet, if you do but want to use a separate db for this, go to config/database.ym and change teh database name for development and test.
 2. Run on console `rails db:migrate`
 3. Run on console `rails db:seed`

You are all set now. To make sure everything is set up run the specs with the following command:
`rspec`

It should output this:
`30 examples, 0 failures`


### Testing the API
 - Run this curl request from a console, Example 1
```
curl --location --request GET 'localhost:3000/api/v1/pay_rates/1/pay_amount' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer tokennn' \
--data-raw '{
    "clients": 30
}'
```

Expected response:
```
{
    "data": {
        "id": "1",
        "type": "amount",
        "attributes": {
            "amount": 165.0,
            "clients": 30
        }
    }
}
```

- Run this curl request from a console, Example 2
```
curl --location --request GET 'localhost:3000/api/v1/pay_rates/1/pay_amount' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer tokennn' \
--data-raw '{
    "clients": 15
}'
```

Expected response:
```
{
    "data": {
        "id": "1",
        "type": "amount",
        "attributes": {
            "amount": 75.0,
            "clients": 15
        }
    }
}
```

- Run this curl request from a console, Example 3
```
curl --location --request GET 'localhost:3000/api/v1/pay_rates/2/pay_amount' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer tokennn' \
--data-raw '{
    "clients": 30
}'
```

Expected response:
```
{
    "data": {
        "id": "2",
        "type": "amount",
        "attributes": {
            "amount": 165.0,
            "clients": 30
        }
    }
```

- Run this curl request from a console, Example 4
```
curl --location --request GET 'localhost:3000/api/v1/pay_rates/2/pay_amount' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer tokennn' \
--data-raw '{
    "clients": 45
}'
```

Expected response:
```
{
    "data": {
        "id": "2",
        "type": "amount",
        "attributes": {
            "amount": 270.0,
            "clients": 45
        }
    }
```
