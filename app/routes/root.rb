namespace '/' do
  @offset = 100

  get do
    erb 'index'
  end

  post 'new' do
    params = JSON.parse(request.body.read)
    if params["content"].nil? or params["lexer"].nil?
      status 403
      puts params.inspect
      'Incomplete.'
    else
      paste = Paste.new(
        :content => params["content"],
        :lexer => params["lexer"]
      )
      if paste.save then
        status 200
        (paste.id + @offset).to_s(30)
      else
        status 500
        'Something went terribly wrong.'
      end
    end
  end

  get 'view/:paste_id' do
    raise Sinatra::NotFound unless params[:paste_id].match /\d+/
    paste = Paste.get(params[:paste_id].to_i(30) - @offset)
    raise Sinatra::NotFound if paste.nil?
    @code = Pygments.highlight(paste.content, :options => {
      :linenos => 'table'
      }, :lexer => paste.lexer.downcase)
    erb 'view'
  end

  get 'raw/:paste_id' do
    raise Sinatra::NotFound unless params["paste_id"].match /\d+/
    paste = Paste.get(params["paste_id"])
    raise Sinatra::NotFound if paste.nil?
    paste.content
  end
end

not_found do
  erb '404'
end
