# Such Coin - Wow #
[![Build Status](https://travis-ci.org/phereford/such_coin_wow.png?branch=master)](https://travis-ci.org/phereford/such_coin_wow)
[![Coverage Status](https://coveralls.io/repos/phereford/such_coin_wow/badge.png)](https://coveralls.io/r/phereford/such_coin_wow)
## Summary ##
This project is a web application that allows Cryptocurrency miners track their
profitability. Since most online wallets get hacked rather frequently, this app
is meant to be a single user application that can be run locally or deployed to
the cloud. I run this locally to track my profitability for various coins.

## Dependencies ##
To run this project locally you need:
- Postgres
- Ruby
- Rails
- Bundler

## Setup ##
```
git clone git@github.com:phereford/such_coin_wow.git
cd such_coin_wow
rake such_coin_wow:install
```
The install rake task will setup the database, migrate it, create your single
user account, install all the various dependencies, and create the coins you
mine. You will need to alter the .env file in order to setup the various user,
password, and port arguments for each JSON-RPC server you run locally (i.e. each
wallet you have open/each coin you mine). The variable names must match the
pattern ```"#{coin.ticker}_VAR"```. Here is an example:
```
DOGE_USER=<INSERT USER NAME>
DOGE_PASSWORD=<INSERT PASSWORD>
DOGE_PORT=<INSERT PORT>
```

IF you can not run the console variation of the wallet, be sure to pass in the 
-server argument to be able to connect to your wallet via JSON-RPC. i.e
```
> ./Dogecoin -server
```

## Running the Server ##
After you set up the various wallet user/password/port variables, you will need
to start each wallet with the -server option. Alternatively you can compile the
various wallet json-rpc command line exectuables and run those.
```
foreman start
```

## Contributing ##
1. Take a gander at [feature requests](https://github.com/phereford/such_coin_wow/issues?labels=Feature+Request&page=1&state=open) and [issues](https://github.com/phereford/such_coin_wow/issues) to make sure your bug has
not been reported.
2. Submit an issue with steps to reproduce the issue.
3. Submit a pull request with associated tests.

## Donations Welcome ##
We are going to do something very different with donations. Any and all
contributors that get something merged into master will share in the donation pool.
Here are the addresses to send some coins:  
__*BTC*: 1EUfts1TAEYqu8Aq2inAWMUDztrRisBo79  
*LTC*: LgsUHBo6QFfCmvhJTnxSufPTDo7KUkyrXV  
*DOGE*: DBwZxLZD6iecz9ZEECHv71tHDwToZxnUpr__  
