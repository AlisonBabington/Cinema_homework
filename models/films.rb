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

    # def find_stars()
    #   sql = "SELECT stars.* FROM stars
    #   INNER JOIN castings
    #   ON castings.star_id = stars.id
    #   INNER JOIN films
    #   ON films.id = castings.film_id
    #   WHERE castings.film_id = $1"
    #   values = [@id]
    #   stars = SqlRunner.run(sql, values)
    #   result = Star.map_items(stars)
    # end

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
      p "All films have been deleted"
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
