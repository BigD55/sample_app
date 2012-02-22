# == Schema Information
#
# Table name: blogs
#
#  id          :integer         not null, primary key
#  title       :string(255)
#  description :string(255)
#  user_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#

require 'spec_helper'

describe Blog do

  before(:each) do
     @user = Factory(:user)
     @attr = { :title => "Beispiel Titel", 
               :description => "was auch immer"
             } 

  end
  it "sollte eine neue Blog Instanz schaffen, wenn die Attribute valide sind" do
     @user.blogs.create!(@attr)
  end  
  it "sollte einen Titel erfordern" do
     ohne_titel_blog = @user.blogs.new(@attr.merge(:title => ""))
     ohne_titel_blog.should_not be_valid
  end 
  it "should reject titles that are too long" do
       long_title = "a" * 141
       long_title_blog = @user.blogs.new(@attr.merge(:title => long_title))
       long_title_blog.should_not be_valid
  end
  it "sollte doppelte Titel zurueckweisen" do
     # Blog mit bestimmtem Titel in Datenbank schreiben"
     @user.blogs.create!(@attr)
     blog_mit_doppeltem_titel = @user.blogs.new(@attr)
     blog_mit_doppeltem_titel.should_not be_valid    
  end
  it "sollte bis auf Grossschreibung identische Titel zurueckweisen" do
     upcased_title = @attr[:title].upcase
     @user.blogs.create!(@attr.merge(:title => upcased_title))
     blog_mit_doppeltem_titel = @user.blogs.new(@attr)
     blog_mit_doppeltem_titel.should_not be_valid    
  end
  it "sollte eine Beschreibung erfordern" do
     ohne_beschreibung_blog = @user.blogs.new(@attr.merge(:description => ""))
     ohne_beschreibung_blog.should_not be_valid
  end
  it "should reject descriptions that are too long" do
       long_description = "a" * 141
       long_description_blog = @user.blogs.new(@attr.merge(:description => long_description))
       long_description_blog.should_not be_valid
  end
  describe "User zuordnung" do
    before(:each) do
       @blog = @user.blogs.create(@attr)
    end
    it "sollte ein User Attribut haben" do
       @user.should respond_to(:blogs)    
    end
    it "sollte den richtig zugeordneten User haben" do
       @blog.user_id.should == @user.id
       @blog.user.should == @user
    end 
  end
  describe "Ueberpruefungen (validations)" do
    it "sollte eine user id erfordern" do
       Blog.new(@attr).should_not be_valid
    end
    it "sollte Titel mit Text erfordern" do
       @user.blogs.build(:title => " ").should_not be_valid
    end
    it "sollte eine Beschreibung mit Text erfordern" do
       @user.blogs.build(:description => " ").should_not be_valid
    end
   it "sollte einen ueberlangen Titel zurueckweisen" do
       @user.blogs.build(:title => "a" * 100).should_not be_valid
    end

    it "sollte eine ueberlange Beschreibung zurueckweisen" do
       @user.blogs.build(:description => "a" * 258).should_not be_valid
    end
  end
end
