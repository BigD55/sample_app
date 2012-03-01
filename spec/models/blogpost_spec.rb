require 'spec_helper'

describe Blogpost do
   before(:each) do
      @user = Factory(:user, :email => Factory.next(:email))
      @blog = Factory(:blog, :user => @user) 
      @attr = { :title => "irgendein Mist xxx", 
                :content => "noch mehr Mist", 
                :blog_id => @blog.id }
   end
   it "should create a new instance given valid attributes" do
     @user.blogposts.create!(@attr)
   end
   describe "blog associations" do
     before(:each) do
        @blogpost = @blog.blogposts.create(@attr)
     end
     it "should have a blog attribute"  do
        @blogpost.should respond_to(:blog)
     end
     it "should respond to the right blog" do
        @blogpost.blog_id.should == @blog.id
        @blogpost.blog.should == @blog
     end
   end
   describe "user associations" do
     before(:each) do
        @blogpost = @user.blogposts.create(@attr)
     end
     it "should have a user attribute"  do
        @blogpost.should respond_to(:user)
     end
     it "should respond to the right userg" do
        @blogpost.user_id.should == @user.id
        @blogpost.user.should == @user
     end
   end
   describe "validations" do
     it "should require a blog_id & user id" do
         Blogpost.new(@attr).should_not be_valid  
     end
     it "should require nonblank content" do
         @blog.blogposts.build(:content => " ").should_not be_valid
     end
     it "should require non blank title" do
         @blog.blogposts.build(:title => " ").should_not be_valid
     end
     it "should reject long title" do
         @blog.blogposts.build(:title => "a" * 110).should_not be_valid
     end
     it "should reject long content" do
         @blog.blogposts.build(:content => "a" * 11000).should_not be_valid
     end
   end
end
