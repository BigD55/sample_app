require 'spec_helper'

describe Blogpost do
   before(:each) do
      @user = Factory(:user)
      @attr = {
         :title => "value for title",
         :content => "value for content"
       }
   end
   it "should create a new instance given valid attributes" do
     @user.blogposts.create!(@attr)
   end
   describe "user associations" do
     before(:each) do
        @blogpost = @user.blogposts.create(@attr)
     end
     it "should have a user attribute"  do
        @blogpost.should respond_to(:user)
     end
     it "should respond to the right user" do
        @blogpost.user_id.should == @user.id
        @blogpost.user.should == @user
     end
   end
   describe "validations" do
     it "should require a user id" do
         Blogpost.new(@attr).should_not be_valid
     end
     it "should require nonblank content" do
         @user.blogposts.build(:content => " ").should_not be_valid
     end
     it "should require non blank title" do
         @user.blogposts.build(:title => " ").should_not be_valid
     end
   end
end
