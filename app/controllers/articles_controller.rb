class ArticlesController < ApplicationController
  skip_before_action :verify_authenticity_token 
  before_action :set_article, only: [:show, :like, :read, :ignore]
  # before_filter :authenticate_subscriber!, only: [:like, :share, :ignore]

  def features
    @page = params[:page] || 0
    @articles = Article.featured.page params[:page]
  end    

  # GET /articles
  # GET /articles.json
  def index

    @page = params[:page] || 0
    @featured = Article.featured.first(4)          

    if subscriber_signed_in?
      # need to fetch articles from the users preferred categories      
      @articles = Article.get_articles current_subscriber, params[:page]
      @combined = @articles.concat(@featured).shuffle!
    else      
      @articles = Article.fresh.page params[:page]
      @combined = @articles.concat(@featured).shuffle!
    end    

    @total_pages = @articles.total_pages
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    # TODO: include number of likes and shares

    log('read')

  end

  # POST /articles/1/like
  # POST /articles/1/like.json
  # Recording a user liking an article
  # must have an active subscriber
  def like

    @subscriber = current_subscriber
    # TODO
    # Send preference to either predicion io or ahoy

    log('like')

    render json: { success: true }
  end

  # POST /articles/1/share
  # POST /articles/1/share.json
  #
  # :id
  # :provider - think of better name
  def share

    # TODO:
    # Record the shares

    log('share')

    render json: { success: true }
  end

  # POST /articles/1/ingore
  # POST /articles/1/ingore.json
  #
  # :id
  def ignore

    log('ignore')

    render json: { success: true }
  end


  def read
  end

  # POST /articles/search?term=q
  # search for articles
  # should do local search for articles as well as perform live search on juicer?
  def search

    # TODO: Implement elastic search
    @articles = Article.fresh.where("body like ?", "%#{params[:term]}%").order(created_at: :desc).page params[:page]

    # TODO
    # Record search element and tie it to category metadata and sources
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    def log type
      # only log if we have a logged in user
      if subscriber_signed_in?
        ArticleLog.create! article: @article, subscriber: current_subscriber, log_type: type
      end
    end
end
