
get '/' do
  mems = Memo.latests(100).map{|m|
    "<p>#{Rack::Utils.escape_html m.body} - #{m.created_at}<p>"
  }.join('')

  "<html><form method='POST' action='/'><input type='text' name='body' size=70 /><input type='submit' /></form>#{mems}</html>"
end

post '/' do
  m = Memo.new :body => params[:body]
  m.save!
  redirect '/'
end
