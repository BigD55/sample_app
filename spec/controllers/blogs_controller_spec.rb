require 'spec_helper'

describe BlogsController do
  render_views
  before(:each) do
    @base_title = "Ruby on Rails diminishes spirituality"
  end
  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
    it "should have the right title" do
     get 'new'
     response.should have_selector("title", :content => @base_title + "| Create New Blog")
    end
  end
  describe "POST 'create'" do
    before(:each) do
      @user = test_sign_in(Factory(:user))
    end
    describe "failure" do
      before(:each) do
        @attr = { :title => "", :description => "" }
      end
      it "should not create a blog" do
        lambda do
           post :create, :blog => @attr
           end.should_not change(Blog, :count)
        end

      it "should have the right title" do
           post :create, :blog => @attr
           response.should have_selector("title", :content =>  @base_title + "| Create New Blog")
      end
      it "should render the 'new' page" do
           post :create, :blog => @attr
           response.should render_template('new')
      end
    end
  end
end
