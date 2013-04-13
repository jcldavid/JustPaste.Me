DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, 'postgres://justpaste:ihat3this@localhost/justpaste')
