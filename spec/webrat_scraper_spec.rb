require File.dirname(__FILE__) + '/spec_helper'

describe WebratScraper do
  describe "instance methods" do
    before(:each) do
      FakeWeb.register_uri(:get, "http://example.com/", :body => "Hello World!")
    end
    
    describe "#doc" do
      it "is a Nokogiri object of of the response body" do
        scraper = WebratScraper.new
        scraper.visit "http://www.example.com/"
        scraper.doc.class.should == Nokogiri::HTML::Document
      end
    end
    
    describe "user_agent=" do
      it "sets the user_agent" do
        scraper = WebratScraper.new
        scraper.user_agent = user_agent = "Test User Agent 1.0"
        scraper.visit "http://www.example.com/"
        scraper.user_agent.should == user_agent
        scraper.mechanize.user_agent.should == user_agent
      end
    end
  end
  
end
