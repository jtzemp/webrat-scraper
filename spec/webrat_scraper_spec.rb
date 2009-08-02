require File.dirname(__FILE__) + '/spec_helper'

describe WebratScraper do
  describe "instance methods" do
    before(:all) do
      FakeWeb.register_uri(:get, "http://example.com/", :body => "Hello World!")
    end
    
    before(:each) do
      @session = WebratScraper.new
    end
    
    describe "#doc" do
      it "is a Nokogiri object of of the response body" do
        @session.visit "http://www.example.com/"
        @session.doc.class.should == Nokogiri::HTML::Document
      end
    end
    
    describe "#user_agent=" do
      it "sets the user_agent" do
        @session.user_agent = user_agent = "Test User Agent 1.0"
        @session.visit "http://www.example.com/"
        @session.user_agent.should == user_agent
        @session.mechanize.user_agent.should == user_agent
      end
    end
  end
  
  describe "webrat's methods" do
    before(:all) do
      FakeWeb.register_uri(:get, "http://example.com/", :body => "Hello World!")
      FakeWeb.register_uri(:get, "http://example.com/1", :body => "Hello World 1!")
      FakeWeb.register_uri(:get, "http://example.com/2", :body => "Hello World 2!")
    end
    
    before(:each) do
      @session = WebratScraper.new
    end

    describe "#visit" do
      it "visits a webpage and updates the context" do
        @session.visit("http://example.com/")
        @session.doc.inner_text.should == "Hello World!"
        
        @session.visit("http://example.com/1")
        @session.doc.inner_text.should == "Hello World 1!"
      end
    end
    
    describe "#fill_in" do
      it "fills in a form" do
        FakeWeb.register_uri(:get, "http://www.google.com", :body => open_fixture(:google_homepage) )
        @session.visit "http://www.google.com"
        lambda {@session.fill_in "q", :with => "webrat-scraper"}.should_not raise_error
      end
    end
    
    describe "#click_link" do
      it "clicks a link" do
        
      end
    end
    
    describe "#click_button" do
      it "clicks a button" do
        
      end
    end
    
    describe "#assert_contain" do
      it "asserts that the page contains the string given" do
        
      end
    end
  end
end
