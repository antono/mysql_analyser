MysqlTest.define 'table_open_cache_test' do
 
  desc 'Test for table_open_cache size'
  tags 'performance', 'caching'

  def run!
    test_table_open_cache_size
  end

  def test_table_open_cache_size
    variable_name        = @info.version > '5.1.3' ? :table_open_cache : :table_cache  # deprecated for 5.1.3
    table_open_cache     = @info.variables[variable_name]       # The number of open tables for all threads. 
    opened_tables        = @info.status[:Opened_tables]         # The number of tables that have been opened. 
    max_connections      = @info.variables[:max_connections]    # The number of simultaneous client connections allowed.
    max_used_connections = @info.status[:Max_used_connections]  # The maximum number of connections that have 
                                                                # been in use simultaneously since the server started. 
    if table_open_cache < (max_connections * 2)
      @logger.info "#{variable_name.to_s} have to be bigger"
    end
    @logger.debug "Testlog"
  end

end
