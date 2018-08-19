require_relative ('../db/sql_runner.rb')

class Film

    attr_reader :id
    attr_accessor :title, :price

    def initialize(details)
      @id = details["id"].to_i if details["id"]
      @title = details["title"]
      @price = details["price"].to_i
    end

    def save()
      sql = "INSERT INTO films (title, price)
      VALUES ($1, $2)
      RETURNING id"
      values = [@title, @price]
      film = SqlRunner.run(sql, values).first
      @id = film['id'].to_i
    end

    def update()
      sql = "UPDATE films
      SET (title, price) = ($1, $2)
      WHERE id = $3 "
      values = [@title, @price, @id ]
      SqlRunner.run(sql, values)
      p "This film has been updated"
    end

    def delete()
      sql = "DELETE FROM films
      WHERE id = $1"
      values = [@id]
      SqlRunner.run(sql, values)
      p "This film has been deleted"
    end

    def how_many_watching()
      sql = "SELECT customers.name FROM customers
      INNER JOIN tickets
      ON tickets.customer_id = customers.id
      WHERE film_id = $1"
      values = [@id]
      customers = SqlRunner.run(sql,values)
      result_array = []
      customers.map{|customer| result_array << customer}
      return result_array.size
    end

    def find_customers()
      sql = "SELECT customers.* FROM customers
      INNER JOIN tickets
      ON tickets.customer_id = customers.id
      WHERE film_id = $1"
      values = [@id]
      customers = SqlRunner.run(sql, values)
      result = Customer.map_items(customers)
    end

    def most_popular_screening()
      sql = "SELECT tickets.* FROM tickets
      INNER JOIN screenings
      ON tickets.screening_id = screenings.id
      INNER JOIN films
      ON films.id = screenings.film_id
      WHERE films.id = $1"
      values = [@id]
      tickets = SqlRunner.run(sql, values)
      result = Ticket.map_items(tickets)
    end

    def self.find_by_id(id)
      sql = "SELECT * FROM films
      WHERE id = $1"
      values = [id]
      result = SqlRunner.run(sql, values)
      final_result =  Film.map_items(result)
      return final_result if final_result.count > 0
      return nil
    end

    def self.find_by_name(name)
      sql = "SELECT * FROM films
      WHERE id = $1"
      values = [name]
      result = SqlRunner.run(sql, values)
      final_result =  Film.map_items(result)
      return final_result if final_result.count > 0
      return nil
    end

    def self.delete_all()
      sql = "DELETE FROM films"
      SqlRunner.run(sql)
    end

    def self.all()
      sql = "SELECT * FROM films"
      films = SqlRunner.run(sql)
      return Film.map_items(films)
    end

    def self.map_items(film_data)
      result = film_data.map { |film| Film.new(film)}
      return result
    end

end
