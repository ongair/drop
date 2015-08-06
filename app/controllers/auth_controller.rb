class AuthController < ApplicationController
  # TODO: fix this once front-end is done 
  skip_before_action :verify_authenticity_token 

  # Works as both a sign in and sign up method
  # by taking the provider and token returned
  # from either FB/TWITTER and the token
  # as well as other personalization params
  # 
  # @provider
  # @uid
  # @name
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

end