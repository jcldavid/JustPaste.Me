namespace '/' do
  before {
    @title = 'Hey there!';
  }
  get do
    # example usage of run_later
    #   wait 3 seconds after URL is called
    #   output to console
    run_later do
      # sleep 3 # go ahead and wait
      logger.info "\nLengthy process has finished!\n\n" # outputs to the log AFTER the page has rendered because run_later doesn't block the rest of the process :)
    end

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
        paste.id.to_s
      else
        status 500
        'Something went terribly wrong.'
      end
    end
  end

  get 'view/:paste_id' do
    raise Sinatra::NotFound unless params["paste_id"].match /\d+/
    paste = Paste.get(params["paste_id"])
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
