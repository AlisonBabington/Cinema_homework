require_relative ('../db/sql_runner.rb')

class Screening

  attr_reader :id
  attr_accessor :film_id, :film_screen, :film_time

  def initialize(details)
    @id = details['id'].to_i if details['id']
    @film_id = details['film_id']
    @film_screen = details['film_screen'].to_i
    @film_time = details['film_time']
  end

  def save()
    sql = "INSERT INTO screenings (film_id, film_screen, film_time)
    VALUES ($1, $2, $3)
    RETURNING ID"
    values = [@film_id, @film_screen, @film_time]
    screening = SqlRunner.run(sql, values).first
    @id = screening['id'].to_i
  end

  def update()
    sql = "UPDATE screenings
    SET (film_id, film_screen, film_time) = ($1, $2, $3)
    WHERE id = $4 "
    values = [@film_id, @film_screen, @film_time, @id]
    SqlRunner.run(sql, values)
    p "This screening has been updated"
  end

  def delete()
    sql = "DELETE FROM screenings
    WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
    p "This screening has been deleted"
  end

  def self.all()
    sql = "SELECT * FROM screenings"
    screenings = SqlRunner.run(sql)
    return Screening.map_items(screenings)
  end

  def self.map_items(screening_data)
    result = screening_data.map { |screening| Screening.new(screening)}
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM screenings"
    SqlRunner.run(sql)
  end

end
