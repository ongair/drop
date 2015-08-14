class ArticlesController < ApplicationController
  skip_before_action :verify_authenticity_token 
  before_action :set_article, only: [:show, :like, :read, :ignore]
  before_filter :authenticate_subscriber!, only: [:like, :share, :ignore]

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.fresh.page params[:page]

    # need to figure out which articles that the user
    # has read
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
    @articles = []

    # TODO
    # Record search element and tie it to category metadata and sources

    # Render the index view
    render view: 'index'
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    def log type
      # only log if we have a logged in user
      if current_subscriber_logged_in?
        ArticleLog.create! article: @article, subscriber: @subscriber, log_type: type
      end
    end
end
