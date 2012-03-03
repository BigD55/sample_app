class BlogpostsController < ApplicationController
    before_filter :authenticate, :only => [:create, :destroy]
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
        @title = "Create New Blog"
    end
    def destroy
    end
    def index 
    end
end
