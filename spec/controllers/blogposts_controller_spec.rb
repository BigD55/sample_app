require 'spec_helper'


describe BlogpostsController do
    render_views
    describe "POST 'create'" do
        before(:each) do
           @user = test_sign_in(Factory(:user))
        end
        describe "success" do
   # Hier hätte ich gerne einen Test der Überprüft den Fall dass
   # statt "Lorem ipsum" "|Lorem| ipsum" erscheint. ein ganz anderer Weg.
   # sollte auch den ersten Test (count() erhöhen, 
   # aber der redirect sollte.... auf die "Blogeditor" Version oder
   # Seite gehen, und vorher sollte der Content auf die || Zeichen 
   # geprüft werden, und den Inhalt in den Titel schreiben. ... und dann erst
   # auf den Blog Editor redirekten. Falls.  
   # I decided to do it differently. Not so easy.
   # also, ganz simpel: es kommt in "blogposts_controller_spec.rb rein
   # ok. Also.... ^^^^
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
