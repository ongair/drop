require 'bbc'
RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :admin
  end
  config.current_user_method(&:current_admin)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    config.excluded_models << SubscriberCategory

    ## With an audit adapter, you can add:
    # history_index
    # history_show
    collection :update_sources do
      register_instance_option :link_icon do
        'icon-refresh'
      end

      register_instance_option :visible? do
        bindings[:abstract_model].to_s == "Source"
      end

      register_instance_option :http_methods do
          [:get, :post]
      end

      register_instance_option :controller do
        Proc.new do
          if params.has_key?(:submit)
            sources = BBC.get_sources
            sources.each do |s|
              source = Source.find_or_create_by! name: s['name'], juicer_id: s['id']
            end
            redirect_to back_or_index, notice: "Sources refreshed"
          else
            render "update_sources"
          end
        end
      end
    end
  end
end
