require 'webrat'
require 'webrat/mechanize'
require 'test/unit/assertions'

class WebratScraper < Webrat::MechanizeSession
  def initialize(context=nil)
    
    super
  end
  
  def user_agent
    
  end
  
  def user_agent=(new_user_agent)
    
  end
  
  # the Nokogiri object for the response.body for the session's current state.
  def doc
    Nokogiri::HTML(response.body)
  end
end