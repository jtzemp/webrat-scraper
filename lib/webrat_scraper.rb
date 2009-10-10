require 'rubygems'
gem 'webrat', '=0.4.5'
require 'webrat'
require 'webrat/mechanize'
require 'test/unit/assertions'

class WebratScraper < Webrat::MechanizeSession
  include Webrat::Matchers
  include Test::Unit::Assertions
  
  def initialize(context=nil)
    super(context)
  end
  
  def user_agent
    @user_agent ||= "webrat-scraper " + mechanize.user_agent
  end
  
  def user_agent=(new_user_agent)
    @user_agent = mechanize.user_agent = new_user_agent
  end
  
  # the Nokogiri object for the response body for the session's current state.
  alias :doc :dom

  
  # def post(url, data={})
  #   visit(url, :post, data)
  # end
end