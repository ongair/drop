class AuthController < ApplicationController
  # TODO: fix this once front-end is done 
  skip_before_action :verify_authenticity_token 

  # load the current subscriber
  before_action :set_subscriber, except: [:log_in]

  # Ensure the subscriber is authenticated
  before_filter :authenticate_subscriber!, except: [:log_in, :status]

  # Returns if a user is loged in
  def status
    render json: { logged_in: subscriber_signed_in? }
  end

  # Works as both a sign in and sign up method
  # by taking the provider and token returned
  # from either FB/TWITTER and the token
  # as well as other personalization params
  # 
  # @provider
  # @uid
  # @name
  # 
  # POST
  def log_in
    if params.has_key?(:provider) || (params[:provider] != 'facebook' && params[:provider] != 'twitter')
      if params.has_key?(:uid)
        
        name = params[:name]
        uid = params[:uid]
        provider = params[:provider]

        
        user = Subscriber.find_by(uid: uid, provider: provider)
        is_new = user.nil?
        if is_new
          # this is a new user
          user = Subscriber.create! provider: provider, uid: uid, name: name 
        end

        sign_in(user)
        render json: { created: is_new, success: true }, status: 200        
      else
        render json: { error: "No valid uid provided" }, status: 422  
      end
    else
      render json: { error: "No valid oauth provider was specified" }, status: 422
    end
  end

  # User preferences for the currently signed in user
  # GET
  def preferences
  end

  # Personalize the current users preferences
  # should be an array category ids
  # POST
  def personalize
    if params.has_key?(:categories)
      category_ids = params[:categories]
      
      SubscriberCategory.where(subscriber: @subscriber).delete_all
      category_ids.each do |cat_id|
        category = Category.find(cat_id)
        SubscriberCategory.create! subscriber: @subscriber, category: category
      end

      # redirect_to preferences_path, format: 'json'
      render json: { updated: true }, status: 200 
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subscriber
      @subscriber = current_subscriber
    end

end