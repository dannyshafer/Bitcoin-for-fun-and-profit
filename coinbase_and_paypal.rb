require 'coinbase/wallet'
require 'paypal-sdk-rest'
require 'selenium-webdriver'
require 'dotenv'
Dotenv.load

driver = Selenium::WebDriver.for :chrome
driver.navigate.to "https://www.paypal.com/signin?country.x=US&locale.x=en_US"

email = driver.find_element(name: 'login_email')
email.send_keys ENV['PAYPAL_EMAIL']
password = driver.find_element(name: 'login_password')
password.send_keys ENV['PAYPAL_PASSWORD']
email.submit

wait = Selenium::WebDriver::Wait.new(:timeout => 10)
wait.until {
  withdrawFunds = driver.find_element(id: 'withdrawFunds')
}

driver.execute_script( "window.open()" )
driver.switch_to.window( driver.window_handles.last )
driver.get 'https://www.paypal.com/myaccount/wallet/withdraw'

wait = Selenium::WebDriver::Wait.new(:timeout => 10)
wait.until {
  overviewPanel = driver.find_element(:class, 'enforceLtr')
}

overviewPanel = driver.find_element(:class, 'enforceLtr')
withdraw_field = driver.find_element(id: 'amount')
new_value = overviewPanel.attribute('innerHTML').split('')[1..-1].join('')
withdraw_field.send_keys new_value

wait = Selenium::WebDriver::Wait.new(:timeout => 3)
click_button = driver.find_element(name: 'continue').click
wait = Selenium::WebDriver::Wait.new(:timeout => 10)
wait.until {
  driver.find_element(name: 'confirm')
}
driver.find_element(name: 'confirm').click

sleep 1

driver.quit

client = Coinbase::Wallet::Client.new(api_key: ENV['COINBASE_API_KEY'], api_secret: ENV['COINBASE_API_SECRET'])
account = client.primary_account
account.send(to: ENV['WALLET_ADDRESS'], amount: account.balance, currency: 'BTC', description: 'Enjoy!')
