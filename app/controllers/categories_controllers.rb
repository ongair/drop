class CategoriesController < ApplicationController

  def index
    # TODO: Should we have an order index for display
    # Or use prediction.io
    @categories = Categories.all
  end
end
