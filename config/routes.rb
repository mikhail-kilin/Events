Rails.application.routes.draw do
  root to: "pages#welcome"
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }

  get 'user', to: "pages#user", as: 'user'

  resources :events do
    collection do
      get 'by_date/:day/:month/:year', action: :by_date,
          constraints: { day: /[0-9]+/, month: /[0-9]+/, year: /[0-9]+/ }, as: 'by_date'
      get 'by_month/:month/:year', action: :by_month,
          constraints: { month: /[0-9]+/, year: /[0-9]+/ }, as: 'by_month'
      get 'by_month', action: :by_month, as: 'default_by_month'
    end

    member do
      get 'copy', as: 'copy'
    end
  end
end
