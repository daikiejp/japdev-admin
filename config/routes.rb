Rails.application.routes.draw do
  root "articles#index"

  resources :articles do
    collection do
      get :export_json
    end
  end

  resources :resources do
    collection do
      get :export_json
    end
  end

  resources :versions do
    member do
      post :fetch_github
    end
    collection do
      get :export_json
      post :fetch_all_github
    end
  end

  resources :devsheet_categories, path: "devsheet" do
    member do
      get :export_json
    end
    collection do
      get :export_all_json
    end

    resources :devsheet_topics, path: "topics" do
      member do
        get :export_json
      end
      collection do
        get :export_all_topics_json
      end

      resources :devsheet_sections, path: "sections" do
        collection do
          get :export_section_json
        end

        resources :devsheet_code_blocks, path: "code_blocks", only: [ :new, :create, :edit, :update, :destroy ]
      end
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
