require "test/unit"
require "mysql_analyser"
require "mysql_test"

class TestMysqlTest < Test::Unit::TestCase

  def setup
    @analyser        = MysqlAnalyser.new('config.yaml')
    MysqlTest.logger = @analyser.logger
    MysqlTest.db     = @analyser.db
  end

  def test_test_loading
    MysqlTest.load_tests
    assert MysqlTest.children.is_a? Hash
    first_child = MysqlTest.children[MysqlTest.children.keys.first]
    assert first_child.class        == MysqlTest
    assert first_child.db.class     == Mysql
    assert first_child.info.class   == MysqlInfo
    assert first_child.logger.class == Logger
    assert first_child.logger.respond_to? :debug
    assert first_child.db.respond_to? :query
  end

  def test_test_loading_tagged
    MysqlTest.load_tests(:security)
    assert MysqlTest.children.collect { |key,value| value }.find_all { |test| !test.tags.include? 'security' }.size == 0
  end

  def test_run_test
    MysqlTest.load_tests
    MysqlTest.children[MysqlTest.children.keys.first].run!
  end

end
