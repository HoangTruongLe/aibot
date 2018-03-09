Rails.application.routes.draw do
  resources :tutorials, except: [:new]
  get 'tutorials/:chatbot_id/new', to: 'tutorials#new'
  resources :line_messages, except: [:new]
  get 'line_messages/:chatbot_id/new', to: 'line_messages#new'
  resources :chatbot_emotion_photos
  resources :chatbots
  # Rails Admin
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # Authen by Devise
  devise_for :users

  # API
  api_version(:module => "V1", :path => {:value => "v1"}, :defaults => {:format => "json"}) do
    # resources :api_statistics
    resources :messages
    post 'user_message', to: 'input_statistic#create'
    post 'user_click', to: 'click_statistic#create'
    post 'user_dislike', to: 'dislike_statistic#create'

    post 'start_chatbot', to: 'session_statistic#create'
    post 'update_statistic', to: 'session_statistic#update'

    resources :categories
    resources :products do
      member do
        get 'chatbot_show_product', :defaults => { :format => 'json' }
      end
      collection do
        get 'chatbot_show_products'
      end
    end
    get 'get_message', to: 'messages#get_message'
    get 'initial_chatbot', to: 'messages#initial_chatbot'
    post 'display_statistic', to: 'api_statistics#display_statistic'
    post 'click_statistic', to: 'api_statistics#click_statistic'

    post 'send_chatbot_log', to: 'chatbot_logs#send_chatbot_log'

    post 'update_conversation_status', to: 'conversation_status#update_conversation_status'
    get 'render_conversation', to: 'conversation_status#render_conversation'
    post 'update_chatting', to: 'conversation_status#update_chatting'

    post 'user_access', to: 'user_accesses#user_access'

    post 'tracking_cv_tag', to: 'conversion_tags#tracking_cv_tag'
  end

  # Web System
  root to: "home#index"

  get '/profile', to: 'home#user_profile'
  patch '/profile', to: 'home#update_user'

  get 'statistics/products', to: 'statistics#products'
  get 'statistics/sessions', to: 'statistics#index'
  get 'statistics/conversations/:id', to: 'statistics#conversations', as: 'conversation_messages'

  resources :apikey, only: [:index] do
    collection do
      post :generate_new_api_key
    end
  end
  resources :categories do
    member do
      get :logs
      get :show_log
    end
  end
  resources :products do
    collection do
      post :import_csv
      get :export_csv, defaults: { format: :csv }
      get :export_report, defaults: { format: :csv }
    end
    member do
      get :logs
      get :show_log
    end
  end
  resources :messages do
    member do
      get 'message_preview'
      get 'preview'
      get 'copy_message'
      get :message_detail_report, defaults: { format: :csv }
    end
    collection do
      get :product, as: :message_product_search
      get :form, as: :message_form_search
      get :summary_message_report, defaults: { format: :csv }
    end
  end

  resources :sites do
    collection do
      put :set_current_site
    end
  end
  resources :users
  resources :photos, except: [:show, :destroy]
  resources :link_cards
  resources :forms
  resources :message_contents
  resources :questions
  resources :stories, only: [:index, :show] do
    collection do
      get :story_report, defaults: { format: :csv }
    end
    member do
      get :messages_report, defaults: { format: :csv }
    end
  end

  namespace :master do
    resources :master_categories
    resources :tags
    resources :keywords do
      collection do
        get :relative_keywords_search
        post :import_csv
        get :export_csv, defaults: { format: :csv }
      end
    end
  end
  resources :videos, except: [:show, :destroy]
  get 'photos/message_photos', to: 'photos#message_photos'
  get 'photos/message_photo_group', to: 'photos#message_photo_group'
  delete 'photos/:id/destroy_photo_group/:content_id', to: 'photos#destroy_photo_group'
  delete 'photos/:id', to: 'photos#destroy'
  get 'videos/message_video', to: 'videos#message_video'
  get 'videos/message_video_group', to: 'videos#message_video_group'
  delete 'videos/:id/destroy_video_group/:content_id', to: 'videos#destroy_video_group'
  delete 'videos/:id', to: 'videos#destroy'
  resources :quotes
  resources :text_messages
  resources :product_messages
  resources :form_messages
  resources :partner_sites, only: [:index]
  resources :conversion_tags, only: [:index] do
    collection do
      get :cv_tags_csv, defaults: { format: :csv }
    end
  end
end
