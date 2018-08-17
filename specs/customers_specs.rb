require('minitest/autorun')
require('minitest/rg')

require_relative('../models/customers.rb')
require_relative('../models/films.rb')
require_relative('../models/tickets.rb')

class BarTest < MiniTest::Test

  def setup
    @customer1 = Customer.new({"name" => "Mike Smith","funds" => 500})
    @film2 = Film.new({"title" => "Mean Girls", "price" => 12})
  end

  def test_buy_ticket( )
    @customer1.buy_ticket(@film2)
    assert_equal(488, @customer1.funds)
  end

  def test_store_ticket()
    @customer1.store_tickets(@film2)
    assert_equal(1, @customer1.tickets)
  end

end
