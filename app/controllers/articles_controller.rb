class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :like]
  before_filter :authenticate_subscriber!, only: [:like]

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.all
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
  end

  # POST /articles/1/like
  # POST /articles/1/like.json
  # Recording a user liking an article
  # must have an active subscriber
  def like

    @subscriber = current_subscriber
    # TODO
    # Send preference to either predicion io or ahoy

    render json: { success: true }
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end
end
