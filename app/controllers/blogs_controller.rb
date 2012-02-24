class BlogsController < ApplicationController
  before_filter :authenticate, :only => [:index ]


  def show 
    @blog = Blog.find(params[:id])
    @title = @blog.title
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
  def edit 
      @title = "Edit blog"
      @blog = Blog.find(params[:id])
  end
  def update
     @blog = Blog.find(params[:id])
     if @blog.update_attributes(params[:blog])
        flash[:success] = "Blog title/description updated."
        redirect_to @blog
     else
        @title = "Edit blog"
        render 'edit'
     end
  end
  def index
     @title = "All Blogs"
     @blogs = Blog.paginate(:page => params[:page])
  end
end
