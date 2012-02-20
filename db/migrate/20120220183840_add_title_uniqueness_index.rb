class AddTitleUniquenessIndex < ActiveRecord::Migration
  def self.up
    add_index :blogs, :title, :unique => true
  end

  def self.down
  end
end
