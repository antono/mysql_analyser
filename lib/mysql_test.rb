class MysqlTest

  TESTS_PATH = 'lib/tests/*.rb'

  attr :db
  attr :info
  attr :logger

  @children   = {}
  @logger     = nil
  @db         = nil
  @info       = nil

  class << self 

    attr :children 

    def logger=(logger)
      @logger = logger
    end

    def db=(connection)
      @db   = connection
      @info = MysqlInfo.new(connection)
    end
    
    private :new
  end

  def initialize(db,logger,info)
    @db     = db
    @logger = logger
    @info   = info
  end

  def self.load_tests(*tags)
    Dir[TESTS_PATH].each  { |test| load test }

    tags.each do |tag|
      @children.delete_if { |key,value| not value.tags.include?(tag) }
    end
  end

  def self.define(test_name, &block)
    test = new(@db,@logger,@info)
    test.instance_eval(&block)
    @children[test_name] = test
  end

  def desc(description)
    @desc = description
  end

  def tags(*tags)
    @tags = tags
  end

  def run!
    raise NotImplementedError
  end
end
