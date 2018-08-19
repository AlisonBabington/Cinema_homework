require_relative ('../db/sql_runner.rb')

class Customer

  attr_reader :id
  attr_accessor :name, :funds, :tickets

  def initialize(details)
    @id = details['id'].to_i if details['id']
    @name = details['name']
    @funds = details['funds'].to_i
    @tickets = 0
  end

  def save()
    sql = "INSERT INTO customers (name, funds, tickets)
    VALUES ($1, $2, $3)
    RETURNING ID"
    values = [@name, @funds, @tickets]
    customer = SqlRunner.run(sql, values).first
    @id = customer['id'].to_i
  end

  def update()
    sql = "UPDATE customers
    SET (name, funds, tickets) = ($1, $2, $3)
    WHERE id = $4"
    values = [@name, @funds, @tickets, @id]
    SqlRunner.run(sql,values)
    p "Customer details have been updated for #{@name}"
  end

  def find_which_movies()
    sql = "SELECT films.* FROM films
    INNER JOIN tickets
    ON tickets.film_id = films.id
    WHERE customer_id = $1"
    values = [@id]
    films = SqlRunner.run(sql, values)
    return Film.map_items(films)
  end

  def delete()
    sql = "DELETE FROM customers
    WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql,values)
    p "Customer has been deleted"
  end

  def buy_ticket(film)
    @funds -= film.price
    update
  end

  def store_tickets(film, screening)
    buy_ticket(film)
    @tickets += 1
    new_ticket = Ticket.new({"customer_id" => @id, "screening_id" => screening.id })
    new_ticket.save()
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM customers
    WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    final_result =  Customer.map_items(result)
    return final_result if final_result.count > 0
    return nil
  end

  def self.all()
    sql = "SELECT * FROM customers"
    customers = SqlRunner.run(sql)
    return Customer.map_items(customers)
  end

  def self.map_items(customer_data)
    result = customer_data.map { |customer| Customer.new(customer)}
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end



end
