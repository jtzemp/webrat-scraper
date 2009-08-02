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
      FakeWeb.register_uri(:get,  "http://example.com/", :body => "Hello World!")
      FakeWeb.register_uri(:get,  "http://example.com/1", :body => "Hello World 1!")
      FakeWeb.register_uri(:get,  "http://example.com/2", :body => "Hello World 2!")
      FakeWeb.register_uri(:get,  "http://example.com/form", :body => open_fixture("fake_form.html"))
      FakeWeb.register_uri(:post, "http://example.com/action", :body => open_fixture("fake_form_action.html"))
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
      it "fills in a form field with a value" do
        @session.visit "http://example.com/form"
        lambda {@session.fill_in "Username", :with => "who"}.should_not raise_error
      end
    end
    
    describe "#click_link" do
      it "clicks a link" do
        @session.visit "http://example.com/form"
        @session.click_link "Page two"
        @session.doc.inner_text.should == "Hello World 2!"
      end
    end
    
    describe "#click_button" do
      it "clicks a button" do
        @session.visit "http://example.com/form"
        @session.click_button "Save"
        @session.doc.inner_text.should == "Form Post!"
      end
    end
    
    describe "#assert_contain" do
      it "asserts that the page contains the string given" do
        @session.visit "http://example.com/form"
        lambda { @session.assert_contain("Lorem ipsum dolor sit amet") }.should_not raise_error
      end
    end
  end
end
