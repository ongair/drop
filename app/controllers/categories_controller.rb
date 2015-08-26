class CategoriesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_category, only: [:show]

  # GET /categories
  # GET /categories.json
  def index
    # TODO: Should we have an order index for display
    # Or use prediction.io
    @categories = Category.all
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
  end

 
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end
end
