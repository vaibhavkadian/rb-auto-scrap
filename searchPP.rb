require 'rubygems'
require 'mechanize'
require 'logger'
require 'envyable'

Envyable.load('./config/env.yml', 'development')
puts ENV['uri']

agent = Mechanize.new { |a| a.log = Logger.new("mech.log") }
agent.user_agent_alias = 'Windows Mozilla'
agent.add_auth(ENV['uri'], ENV['user'], ENV['password'])
agent.get(ENV['uri']) do |page|
  puts page.title
  
  ## li newsbox li dfwp-item a href
  ## . class .newsbox
  ## # id ex #username
  ## html-element ex a
  ## [] html-element-property ex a[href]
  page.search('.newsbox .dfwp-item a').each do |newsele|
    puts newsele.text.strip
    ##puts newsele['href']
  end
end