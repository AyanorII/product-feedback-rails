Rails.application.routes.draw do
  devise_for :users
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :products do
        collection do
          get :count
          get :suggestions
          get :planned
          get :live
          get 'in-progress'
        end
        member { patch :upvote }
      end
    end
  end
end
