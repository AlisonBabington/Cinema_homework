require_relative('models/customers.rb')
require_relative('models/films.rb')
require_relative('models/tickets.rb')
require_relative('models/screening.rb')

require('pry-byebug')

Customer.delete_all()
Film.delete_all()
Ticket.delete_all()
Screening.delete_all()

customer1 = Customer.new({
  "name" => "Mike Smith", "funds" => "500"})
customer1.save()

customer2 = Customer.new({
  "name" => "Elsie Bower", "funds" => "200"})
customer2.save()

customer3 = Customer.new({
  "name" => "Elliot Samuel", "funds" => "1000"})
customer3.save()

customers = Customer.all()

film1 = Film.new({
  "title" => "Heathers", "price" => "10"
  })
film1.save()

film2 = Film.new({
  "title" => "Mean Girls", "price" => "12"
  })
film2.save()

film3 = Film.new({
  "title" => "Spirited Away", "price" => "9"
  })
film3.save()

films = Film.all()

screening1 = Screening.new({ "film_id" => film1.id, "film_screen" => "2",
"film_time" => "18.50"})
screening1.save()

screening2 = Screening.new({ "film_id" => film1.id, "film_screen" => "2",
"film_time" => "10.50"})
screening2.save()

screening3 = Screening.new({ "film_id" => film2.id, "film_screen" => "3",
  "film_time" => "20.10"})
screening3.save()

screenings = Screening.all()

ticket1 = Ticket.new({
  "customer_id" => customer1.id, "screening_id" => screening1.id})
ticket1.save()

ticket2 = Ticket.new({
  "customer_id" => customer2.id , "screening_id" => screening2.id})
ticket2.save()

ticket3 = Ticket.new({
  "customer_id" => customer1.id , "screening_id" => screening1.id} )
ticket3.save()

ticket4 = Ticket.new({
  "customer_id" => customer3.id , "screening_id" => screening1.id})
ticket4.save()

ticket5 = Ticket.new({
  "customer_id" => customer1.id , "screening_id" => screening3.id})
ticket5.save()

tickets = Ticket.all()

pry.binding
nil
