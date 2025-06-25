class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: %i[ index show ] 

  # GET /posts or /posts.json
  def index
    @posts = Post.all
    
  end

  # GET /posts/1 or /posts/1.json
  def show
    @post.update(views: @post.views + 1) if @post.views.present?
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)
    @post.user = current_user

    respond_to do |format|
      if @post.save
         flash.now[:alert] = "Save post."
        format.html { redirect_to @post, notice: "Post was successfully created." }
        format.turbo_stream
      else
         flash.now[:alert] = "Failed to save post. Please check the errors below."
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream { render turbo_stream: turbo_stream.replace("post_form", partial: "posts/partials/form", locals: { post: @post }) }
      end
    end
  end
  
  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated." }
        format.turbo_stream
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.turbo_stream { render turbo_stream: turbo_stream.replace("post_form", partial: "posts/partials/  form", locals: { post: @post }) }
      end
    end
  end
  

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.turbo_stream
    end
  end
  
  # app/controllers/posts_controller.rb
    def loan_calculation
        Rails.logger.debug params.inspect
     amount = params[:post][:amount]
    term_months = params[:post][:term_months]
    render partial: "posts/partials/loan_calculations", locals: { amount: amount, term_months: term_months }, layout: false
    end
  
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(
    :title,
    :body,
    :borrower_name,
    :amount,
    :interest_rate,
    :term_months,
    :start_date,
    :purpose,
    :status,
    :birthdate,
    :nationality,
    :valid_id,
    :sss_number,
    :payment_mode
      )
    end
    # ...existing code...

   
end
