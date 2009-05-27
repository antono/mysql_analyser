require "test/unit"
require "mysql_version"

class TestMysqlVersion < Test::Unit::TestCase

  def setup
    @version4 = '4.1.13'
    @version5 = '5.0.75-0ubuntu10.1'

    @version5_0_75 = '5.0.75-0ubuntu10.1'
    @version5_1_75 = '5.1.75-0ubuntu10.1'
    @version5_1_76 = '5.1.76-0ubuntu10.1'

    @ubuntu_5_0_75 = MysqlVersion.new(@version5_0_75)
    @ubuntu_5_1_75 = MysqlVersion.new(@version5_1_75)
    @ubuntu_5_1_76 = MysqlVersion.new(@version5_1_76)
  end

  def test_parsing
    assert @ubuntu_5_0_75.is_a? Hash
  end

  def test_build_nil
    buildnil =  MysqlVersion.new(@version4)
    assert buildnil[:build].nil?
    assert buildnil[:major]  == 4
    assert buildnil[:middle] == 1
    assert buildnil[:minor]  == 13
  end

  def test_version
    assert @ubuntu_5_0_75.is_a? Hash
    assert @ubuntu_5_0_75.size == 4
    [:major, :middle, :minor].each do |part| 
      assert @ubuntu_5_0_75[part].is_a? Fixnum
    end
    assert @ubuntu_5_0_75[:build].is_a? String
    assert @ubuntu_5_0_75[:build].match(/ubuntu/)
  end

  def test_string_representation
    assert @ubuntu_5_0_75.to_s == @version5
  end

  def test_version_greater
    assert @ubuntu_5_1_76 > @version5_1_75
    assert @ubuntu_5_1_76 > @version5_0_75
    assert @ubuntu_5_1_75 > @version5_0_75
    assert @ubuntu_5_1_75 > @version4
  end

  def test_versions_equal
    assert @ubuntu_5_1_76 == @version5_1_76
  end

end
