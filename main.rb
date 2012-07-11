
get '/' do
  mems = Memo.latests(100).map{|m|
    "<p>#{Rack::Utils.escape_html m.body} - <a href='/#{m.id}'>#{m.created_at}<a><p>"
  }.join('')

  url = 'https://github.com/shokai/heroku-sinatra-mongo-memo'
  "<html><form method='POST' action='/'><input type='text' name='body' size=70 /><input type='submit' /></form>#{mems}<p><a href='#{url}'>#{url}</a></p></html>"
end

post '/' do
  body = params[:body].to_s
  redirect '/' if body.empty?
  m = Memo.new :body => body
  m.save!
  redirect '/'
end

get '/:id' do
  m = Memo.find_by_id params[:id]
  halt 404, 'not found' unless m
  "<html><p><a href='/'>top</a></p><p>#{Rack::Utils.escape_html m.to_s}</p></html>"
end
