class BlogpostsController < ApplicationController
    before_filter :authenticate, :only => [:create, :destroy]
    def create
        @blogpost = current_user.blogposts.build(params[:blogpost])
      #  @blogpost.merge( :blog_id => @blog.id)
        if @blogpost.save 
           flash[:success] = "Blogpost created!" 
           redirect_to show_blogs_path
        else
           redirect_to create_blogpost_path
        end
    end  
    def destroy
    end
    def index 
    end
end
