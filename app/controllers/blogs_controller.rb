class BlogsController < ApplicationController
  def show 
    @blog = Blog.find(params[:id])
  end 
  def new
    @blog = Blog.new
    @title = "Create New Blog"
  end
  def create
    @blog = current_user.blogs.build(params[:blog])
    if @blog.save
       flash[:success] = "Blog created!"
       redirect_to @blog
    else
       @title = "Create New Blog"
       render 'new'
    end
  end
  def index
     @title = "All Blogs"
     @blogs = Blog.paginate(:page => params[:page])
  end
end
