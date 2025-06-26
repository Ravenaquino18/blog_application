# app/controllers/posts_controller.rb

class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: %i[ index show ] 

  # GET /posts or /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1 or /posts/1.json
  def show
    # Use update! to raise an exception on failure if needed.
    @post.increment!(:views) if @post.views.present?
  end

  # GET /posts/new
  def new
    @post = Post.new
    @post.loan_type = params[:loan_type] if params[:loan_type].present?
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = current_user.posts.build(post_params) # Use build for association
    
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: "Post was successfully created." }
        # Turbo Streams will automatically broadcast the notification
        # as defined in the Post model's after_create_commit callback.
        format.turbo_stream
      else
        # Render the form again with validation errors for Turbo Streams.
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            "new_post_form", # Target the form's ID for replacement
            partial: "posts/form", # Use the main form partial
            locals: { post: @post }
          )
        end
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated." }
        # The broadcast for updates is handled in the Post model's after_update_commit callback.
        format.turbo_stream
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            "edit_post_form", # Target the form's ID for replacement
            partial: "posts/form", # Use the main form partial
            locals: { post: @post }
          )
        end
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      # For Turbo Streams, we can just send a no_content response.
      # The actual removal is handled by the model's after_destroy_commit callback.
      format.turbo_stream { head :no_content }
    end
  end
  
  # app/controllers/posts_controller.rb
    def loan_calculation
      # Use `dig` for safe access to nested parameters to avoid errors if they are missing
      amount = params.dig(:post, :amount)
      term_months = params.dig(:post, :term_months)
      
      # It's better to render a partial with an HTML ID or Turbo Frame ID so it can be targeted
      # by the stimulus controller and replaced.
      render partial: "posts/partials/loan_calculations", locals: { amount: amount, term_months: term_months }, layout: false
    end
  
  # GET /posts/loanselect
  def loanselect
    if params[:loan_type].present?
      redirect_to new_post_path(loan_type: params[:loan_type])
    else
      @post = Post.new
    end
  end

  def approve
    @post = Post.find(params[:id])
    @post.update(status: "Approved")

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to posts_path, notice: "Loan approved." }
    end
  end

  def reject
    @post = Post.find(params[:id])
    @post.update(status: "Rejected")

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to posts_path, notice: "Loan rejected." }
    end
  end

  def validate
    @post = Post.find(params[:id])
    if params[:id_image]
      @post.id_image.attach(params[:id_image]) # ActiveStorage
      flash[:notice] = "ID uploaded for validation."
    else
      flash[:alert] = "Please upload an ID image."
    end
    redirect_to posts_path
  end

  private

    # **UPDATED:** Use `find_by` to prevent a crash if the record is not found.
    def set_post
      @post = Post.find_by(id: params[:id])
      
      # If the post is not found, redirect to prevent an error.
      unless @post
        redirect_to posts_url, alert: "Loan not found."
      end
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(
        :title,
        :body,
        :content,
        :loan_type,
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
        :payment_mode,
        :id_image # Make sure to permit the attached file
      )
    end
end