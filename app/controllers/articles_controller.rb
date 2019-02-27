class ArticlesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_article, only: [:show, :edit, :update, :destroy, :delete, :set_weight, :set_reveal]
  before_action :set_articles, only: [:index, :set_weight, :set_reveal]
  before_action :set_left_bar
  access article: :all, message: "当前用户无权访问"

  # GET /articles
  def index
  end

  def set_reveal
    @article.toggle!(:reveal)
    respond_to do |format|
      format.js do
      end
    end
  end

  def set_weight
    @article.update(weight: Time.now)
    respond_to do |format|
      format.js do
      end
    end
  end

  # GET /articles/1
  def show
  end

  # GET /articles/new
  def new
    @article = current_user.articles.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  def create
    @article = current_user.articles.new(article_params)

    if @article.save
      flash[:success] = "创建成功"
      redirect_to articles_path
    else
      render :new
    end
  end

  # PATCH/PUT /articles/1
  def update
    if @article.update(article_params)
      flash[:success] = "更新成功"
      redirect_to articles_path
    else
      render :edit
    end
  end


  def delete
  end

  # DELETE /articles/1
  def destroy
    @article.destroy
    flash[:success] = "删除成功"
    redirect_to articles_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = current_user.articles.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def article_params
      params.require(:article).permit(:title, :content)
    end

    def set_articles
      @articles = current_user.articles.page(params[:page])
    end

    def set_left_bar
      @available_roles = current_user.roles.reject{ |role| (role == :user) || (role == :root_admin) }.map(&:to_s)
      @options = current_user.options.where(name: @available_roles).where(reveal: true).order(:position)
    end
end
