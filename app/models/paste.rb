class Paste
  include DataMapper::Resource

  property :id, Serial
  property :content, Text
  property :lexer, String
  property :created_at, DateTime
end
