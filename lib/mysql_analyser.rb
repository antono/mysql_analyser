$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) ||
    $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'logger'
require 'mysql'
require 'mysql_info'
require 'mysql_test'
require 'mysql_version'
require 'yaml'
require 'pp'


class MysqlAnalyser

  VERSION = '0.0.1'

  attr :config
  attr :logger
  attr :db

  def initialize(config_path = 'config.yaml')
    @config = YAML.load_file(config_path)
    @logger = Logger.new(@config['log'])
    @db     = Mysql.real_connect(@config['hostname'], @config['username'], @config['password']) 
    @logger.progname = 'Mysql Analyser'
    @logger.info 'Starting MysqlAnalyser'
  end

end
