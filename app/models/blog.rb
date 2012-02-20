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

class Blog < ActiveRecord::Base
  attr_accessible :title, :description, :user_id 


  validates :title, :presence => true, :length => { :maximum => 80 }, 
                                       :uniqueness => { :case_sensitive => false }
  validates :description, :presence => true, :length => { :maximum => 140 }
  validates :user_id, :presence => true
end
