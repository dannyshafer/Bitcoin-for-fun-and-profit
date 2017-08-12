# Bitcoin-for-fun-and-profit 
(inspired loosely by my previous repo: Philanthropy-for-fun-and-profit)


No need to look into what's happening here...but if you do, this is how you'd set it up:


Create a file called .env in the root directory and configure your various credentials:


COINBASE_API_KEY="your_coinbase_api_key"


COINBASE_API_SECRET="your_coinbase_api_secret"


DESTINATION_WALLET_ADDRESS="your_destination_wallet_address"


PAYPAL_EMAIL="your_paypal_email_address"


PAYPAL_PASSWORD="your_paypal_password"



Then do `bundle install` to get the ruby gems you'll need.

`coinbase_and_paypal.rb` holds the brain of the script wherein the majority of the file logs into the PayPal website and goes through the steps to withdraw your account balance to your primary pay out account while the final three lines access the Coinbase api to withdraw your bitcoin balance to the wallet of your choice.


You can run the whole program by entering in a terminal window whose current working directory is the root of the project: `ruby coinbase_and_paypal.rb`


Todo: after completing a withdrawl, navigate to a Google Drive spreadsheet and enter the amount that was withdrawn to an appropriate column for record keeping purposes.
