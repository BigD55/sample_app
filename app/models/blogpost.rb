class Blogpost < ActiveRecord::Base
 attr_accessible :title, :content, :blog_id

 belongs_to :user 
 belongs_to :blog
 validates :title, :presence => true, :length => { :maximum => 100 }
 validates :content, :presence => true, :length => { :maximum => 10000 }
 validates :user_id, :presence => true
 validates :blog_id, :presence => true
 default_scope :order => "blogposts.created_at DESC"
end
