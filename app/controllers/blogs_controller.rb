class BlogsController < ApplicationController
  def show 
    @blog = Blog.find(params[:id])
  end 
  def new
    @title = "create new blog"
  end

end
