require 'rubygems'
require 'mechanize'
require 'logger'
require 'envyable'

Envyable.load('./config/env.yml', 'searchPP')
puts ENV['uri']

agent = Mechanize.new { |a| a.log = Logger.new("searchPP.log") }
agent.user_agent_alias = 'Windows Mozilla'
agent.add_auth(ENV['uri'], ENV['user'], ENV['password'])
agent.get(ENV['uri']) do |page|
  puts page.title
  
  ## li newsbox li dfwp-item a href
  ## . class .newsbox
  ## # id ex #username
  ## html-element ex a
  ## [] html-element-property ex a[href]
  
  ##form = page.forms.first
  ##form.fields.each { |f| puts f.name }
  ##form['ctl00_g_833fc919_2197_4cd5_ae19_c8febbe4ed76_txtPerson'] = 'vaibhav'
  ##link = page.link_with(:title => 'people')
  
  ##personpage = form.submit
  ##personpage = link.click
  ##puts personpage.uri 
end

agent.get(ENV['personuri'] + ENV['personurinamestring']) do |page|
  puts page.uri
  page.search('#UserInfoContainer').each do |person|
    ##puts person.text.strip
    puts '======'
    puts person['src']
    puts person['alt']
  end
  
end