require "test/unit"
require "mysql_analyser"

class TestMysqlAnalyser < Test::Unit::TestCase

  def setup
    @analyser = MysqlAnalyser.new
  end

  def test_initialization
    assert @analyser.db.class == Mysql
    assert @analyser.logger.class == Logger
    assert @analyser.config.class == Hash
  end

end
