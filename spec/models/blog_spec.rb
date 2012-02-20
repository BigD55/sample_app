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
     @attr = { :title => "Beispiel Titel", :description => "was auch immer", :user_id => 1 } 
  end
  it "sollte eine neue Blog Instanz schaffen, wenn die Attribute valide sind" do
     Blog.create!(@attr)
  end  
  it "sollte einen Titel erfordern" do
     ohne_titel_blog = Blog.new(@attr.merge(:title => ""))
     ohne_titel_blog.should_not be_valid
  end 
  it "should reject titles that are too long" do
       long_title = "a" * 141
       long_title_blog = Blog.new(@attr.merge(:title => long_title))
       long_title_blog.should_not be_valid
  end
  it "sollte doppelte Titel zurueckweisen" do
     # Blog mit bestimmtem Titel in Datenbank schreiben"
     Blog.create!(@attr)
     blog_mit_doppeltem_titel = Blog.new(@attr)
     blog_mit_doppeltem_titel.should_not be_valid    
  end
  it "sollte bis auf Grossschreibung identische Titel zurueckweisen" do
     upcased_title = @attr[:title].upcase
     Blog.create!(@attr.merge(:title => upcased_title))
     blog_mit_doppeltem_titel = Blog.new(@attr)
     blog_mit_doppeltem_titel.should_not be_valid    
  end
  it "sollte eine Beschreibung erfordern" do
     ohne_beschreibung_blog = Blog.new(@attr.merge(:description => ""))
     ohne_beschreibung_blog.should_not be_valid
  end
  it "should reject descriptions that are too long" do
       long_description = "a" * 141
       long_description_blog = Blog.new(@attr.merge(:description => long_description))
       long_description_blog.should_not be_valid
  end
  it "sollte eine User ID erfordern" do
     ohne_user_id_blog = Blog.new(@attr.merge(:user_id => nil))
     ohne_user_id_blog.should_not be_valid
  end  
end
