require 'spec_helper'


describe BlogpostsController do
    render_views
    describe "access control" do
        it "should deny access to 'create'" do
           post :create
           response.should redirect_to(signin_path)
        end
        it "should deny access to 'destroy'" do
           delete :destroy, :id => 1
           response.should redirect_to(signin_path)
        end
    end
    describe "POST 'create'" do
        before(:each) do
           @user = test_sign_in(Factory(:user))
           @blog = Factory( :blog, :user => @user )
        end
        describe "failure" do
          before(:each) do
            @attr = { :title => "", :content => "" } 
            
          end 
          it "should not create a blogpost" do
             lambda do
                post :create, :blogpost => @attr
             end.should_not change(Blogpost, :count)
          end
          it "should render the blog page" do
             post :create, :blogpost => @attr                                      
             response.should redirect_to(blog_path)
          end
        end 
        describe "success" do
          before(:each) do
            @attr = { :title => "Rerum aperiam", :content => "Lorem ipsum" }
          end
          it "should create a blogpost" do
            lambda do
              post :create, :blogpost => @attr
            end.should change(Blogpost, :count).by(1)
          end
          it "should redirect to the Blog page" do
            post :create, :blogpost => @attr
            response.should redirect_to(blog_path)
          end
          it "should have a flash message" do
            post :create, :blogpost => @attr
            flash[:success].should =~ /blogpost created/i
          end
       end
    end
end
