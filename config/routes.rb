Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :authentication, only: [] do
        collection do
          post :authenticate
        end
      end
    end
  end
end
