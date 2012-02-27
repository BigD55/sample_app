class Blogpost < ActiveRecord::Base
 attr_accessible :title, :content, :blog_id

 belongs_to :user 
 belongs_to :blog
 validates :title, :presence => true, :length => { :maximum => 100 }
 validates :content, :presence => true, :length => { :maximum => 180 }
 validates :user_id, :presence => true
 validates :blog_id, :presence => true
end
