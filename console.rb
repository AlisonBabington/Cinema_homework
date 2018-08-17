require_relative('models/customers.rb')
require_relative('models/films.rb')
require_relative('models/tickets.rb')

require('pry-byebug')

Customer.delete_all()

customer1 = Customer.new({
  "name" => "Mike Smith",
  "funds" => "500"})
customer1.save()

customer2 = Customer.new({
  "name" => "Elsie Bower",
  "funds" => "200"})
customer2.save()

customer3 = Customer.new({
  "name" => "Elliot Samuel",
  "funds" => "1000"})
customer3.save()

customers = Customer.all()

pry.binding
nil
