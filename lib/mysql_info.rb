class MysqlInfo

  attr :db

  def initialize(db)
    @db = db
  end

  def variables
    @variables ||= variables!
    @variables
  end

  def variables!
    vars = {}
    res = @db.query('show global variables')
    while row = res.fetch_row
      vars[row[0].to_sym] = row[1]
    end
    return vars
  end

  def status
    @status ||= status!
    @status
  end

  def status!
    st = {}
    res = @db.query('show global status')
    while row = res.fetch_row
      st[row[0].to_sym] = row[1]
    end
    return st
  end

  def version
    @version ||= version!
    @version
  end

  def version!
    MysqlVersion.new(variables[:version])
  end

  def processlist
    @processlist ||= processlist!
    @processlist
  end

  def processlist!
    plist = []
    res = @db.query('show full processlist')
    while (row = res.fetch_hash) do plist << row end
    plist
  end

  def innodb_status
    # TODO
  end

end
