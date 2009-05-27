require "test/unit"
require 'mysql_analyser'
require "mysql_info"

class TestMysqlInfo < Test::Unit::TestCase

  def setup
    @analyser = MysqlAnalyser.new
    @info     = MysqlInfo.new(@analyser.db)
  end

  def test_connection
    assert @info.db.class == Mysql
  end

  def test_variables
    assert @info.variables.is_a? Hash
    assert !@info.variables.empty?
  end
  
  def test_status
    assert @info.status.is_a? Hash
    assert !@info.status.empty?
  end

end
