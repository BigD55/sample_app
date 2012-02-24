require 'spec_helper'
require 'database_cleaner'
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
     response.should have_selector("title", :content => "Create New Blog")
    end
  end
  describe "GET 'edit'" do
      before(:each) do
         @user = Factory(:user)
         test_sign_in(@user)
         @blog = Factory(:blog, :user => @user) #<-Dafür musste ich schon etwas googeln. 
                                                # Dasselbe sollte eigentlich auch beim
                                                # "index" funktionieren. 
      end
      it "should be successful" do
         get :edit, :id => @blog
         response.should be_success
      end
      it "should have the right title" do
         get :edit, :id => @blog
         response.should have_selector("title", :content => "Edit blog")
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
  describe "GET 'show'" do
     before(:each) do
       @user = Factory(:user)
       @blog = Factory(:blog, :user => @user)
     end
     it "should be successful" do
       get :show, :id => @blog
       response.should be_success
     end
     it "should find the right blog" do
       get :show, :id => @blog
       assigns(:blog).should == @blog
     end
     it "should have the right title" do
       get :show, :id => @blog
       response.should have_selector("title", :content => @blog.title)
     end
     it "should include the blog's title" do
       get :show, :id => @blog
       response.should have_selector("h1", :content => @blog.title)
     end
#     it "should have a profile image" do
#       get :show, :id => @user
#       response.should have_selector("h1>img", :class => "gravatar")
#     end
#     it "should show the user's microposts" do
#       mp1 = Factory(:micropost, :user => @user, :content => "Foo bar")
#       mp2 = Factory(:micropost, :user => @user, :content => "Baz quux")
#       get :show, :id => @user
#       response.should have_selector("span.content", :content => mp1.content)
#       response.should have_selector("span.content", :content => mp2.content)
#     end
  end
  describe "GET 'index'" do
     describe "for non-signed-in users" do
        it "should deny access" do
           get :index
           response.should redirect_to(signin_path)
           flash[:notice].should =~ /sign in/i
        end
     end
     describe "for signed-in users" do
        before(:each) do
           @user = test_sign_in(Factory(:user))
           @user2 = Factory(:user, :name => Factory.next(:name),
                                   :email => Factory.next(:email))
           @blog = Factory(:blog,  :user => @user) 
           second = Factory(:blog, :title => "Test Blog2", 
                                   :description => "was auch immer", 
                                   :user => @user2)
           third = Factory(:blog, :title => "Test Blog 3", 
                                  :description => "ganz grosser Kaese", 
                                  :user => @user)
           @blogs = [@blog, second, third]
           30.times do
               @blogs << Factory(:blog, :title => Factory.next(:title),
                                        :description => Factory.next(:description), 
                                        :user  => @user2) 
          end
       end
       it "should be successful" do
          get :index
          response.should be_success
       end
       it "should have the right title" do
          get :index
          response.should have_selector("title", :content => "All blogs")
       end
       it "should have an element for each blog" do
          get :index
          @blogs[10..13].each do |blog|
             response.should have_selector("li", :content => blog.title)
          end
       end
       it "should paginate blogs" do
          get :index
          response.should have_selector("div.pagination")
          response.should have_selector("span.disabled", :content => "Previous")
          response.should have_selector("a", :href => "/blogs?page=2",
                                                   :content => "2")
          response.should have_selector("a", :href => "/blogs?page=2",
                                                :content => "Next")
       end
     end
  end
  describe "PUT 'update'" do
     before(:each) do
         @user = Factory(:user)
         test_sign_in(@user)
         @blog = Factory(:blog, :user => @user)
     end
     describe "failure" do
         before(:each) do
             @attr = { :title => "", :description => "" }
         end
         it "should render the 'edit' page" do
             put :update, :id => @blog, :blog => @attr
             response.should render_template('edit')
         end
         it "should have the right title" do
             put :update, :id => @blog, :blog => @attr
             response.should have_selector("title", :content => "Edit blog")
         end
     end
     describe "success" do
         before(:each) do
             @attr = { :title => "New Title", :description => "neue Beschreibung" }
         end
         it "should change the blog's attributes" do
             put :update, :id => @blog, :blog => @attr
             @blog.reload
             @blog.title.should == @attr[:title]
             @blog.description.should == @attr[:description]
         end
         it "should redirect to the blog show page" do
             put :update, :id => @blog, :blog => @attr
             response.should redirect_to(blog_path(@blog))
         end
         it "should have a flash message" do
            put :update, :id => @blog, :blog => @attr
            flash[:success].should =~ /updated/
         end
     end
  end
end
