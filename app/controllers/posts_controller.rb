class PostsController < ApplicationController
  before_action :authenticate_user! ,except: [:index, :welcome, :show]
    
  
    def welcome
    end
   
    def index
      @posts = Post.all.order('id DESC')
      @user = User.all.order('id DESC')
    end
  
    def show
      @post = Post.find(params[:id])
    end
  
    def new
      @post = current_user.posts.build
    end
  
    def edit
      @post = Post.find(params[:id])
    end
  
    def create
      # @post = Post.new(post_params)
      @post = current_user.posts.build(post_params)
  
      if @post.save
        redirect_to @post, notice: "Post was successfully updated."
      else
        render :new, status: :unprocessable_entity
      end
    end
  
    def update
      @post = Post.find(params[:id])
     
        if @post.update(post_params)
         redirect_to @post, notice: "Post was successfully updated."
        
        else
          render :edit, status: :unprocessable_entity
        end
 
    end
  
    def destroy
      @post = Post.find(params[:id])
      @post.destroy
      render :new, status: :see_other
    end
  
    private

      def post_params
        params.require(:post).permit(:title, :content, :user_id)
      end
  end
  