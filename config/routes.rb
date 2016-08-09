Rails.application.routes.draw do

  root "surveys#index"

  resources :surveys do
    resources :questions
  end

  post "submit_response" => "responses#create"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
