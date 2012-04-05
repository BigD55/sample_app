class BlogpostsController < ApplicationController
    
    before_filter :authenticate, :only => [:create, :update, :destroy]
    def create
        @blogpost = current_user.blogposts.build(params[:blogpost])
        if @blogpost.save 
           flash[:success] = "Blogpost created!" 
           redirect_to blog_path(@blogpost.blog_id)
        else
           redirect_to new_blogpost_path
        end
    end  
    def new      
        @blogpost = Blogpost.new
        @blog =  Blog.find(params[:blog_id])    
        @title = "Create New Blogpost"
    end 
    def edit 
      @title = "Edit blogpost"
      @blogpost = Blogpost.find(params[:id])
    end
    def update
      @blogpost = Blogpost.find(params[:id])
      if @blogpost.update_attributes(params[:blogpost])
        flash[:success] = "Blogpost title/content updated."
        redirect_to blog_path(@blogpost.blog_id)
      else
        @title = "Edit blogpost"
        render 'edit'
      end
    end
    def destroy
        @blogpost = Blogpost.find(params[:id])
        @blog_id = @blogpost.blog_id
        @blogpost.destroy
        flash[:success] = "Blogpost destroyed."
        redirect_to blog_path(@blog_id)
    end
    def index 
    end
end
