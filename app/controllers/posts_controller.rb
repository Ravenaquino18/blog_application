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
    @post.loan_type = params[:loan_type] if params[:loan_type].present?
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
        format.html { redirect_to @post, notice: "Post was successfully created." }
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            "post_form",
            partial: "posts/partials/form",
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
        format.turbo_stream
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            "post_form",
            partial: "posts/partials/form",
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
      format.turbo_stream
    end
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

    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :content, :loan_type, :borrower_name, :amount, :interest_rate, :term_months, :start_date, :purpose, :status)
    end
end
