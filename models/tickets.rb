require_relative ('../db/sql_runner.rb')

class Ticket

  def initialize(details)
    @id = details['id'].to_i if details['id']
    @customer_id = details['customer_id'].to_i
    @screening_id = details['screening_id'].to_i
  end

  def save()
    sql = "INSERT INTO tickets (customer_id, screening_id)
    VALUES ($1, $2)
    RETURNING ID"
    values = [@customer_id, @screening_id]
    ticket = SqlRunner.run(sql, values).first
    @id = ticket['id'].to_i
  end

  def update()
    sql = "UPDATE tickets
    SET  (customer_id, screening_id) = ($1, $2, $3)
    WHERE id = $4"
    values = [@film_id, @customer_id, @screening_id, @id]
    SqlRunner.run(sql, values)
    p "This ticket has been updated"
  end

  def delete()
    sql = "DELETE FROM tickets
    WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
    p "This ticket has been deleted"
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM tickets
    WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    final_result =  Ticket.map_items(result)
    return final_result if final_result.count > 0
    return nil
  end


  def self.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM tickets"
    tickets = SqlRunner.run(sql)
    return Ticket.map_items(tickets)
  end

  def self.map_items(ticket_data)
    result = ticket_data.map { |ticket| Ticket.new(ticket)}
    return result
  end

end
