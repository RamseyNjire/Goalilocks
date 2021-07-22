# == Route Map
#
#                    Prefix Verb   URI Pattern                                                                              Controller#Action
#                     users GET    /users(.:format)                                                                         users#index
#                           POST   /users(.:format)                                                                         users#create
#                  new_user GET    /users/new(.:format)                                                                     users#new
#                 edit_user GET    /users/:id/edit(.:format)                                                                users#edit
#                      user GET    /users/:id(.:format)                                                                     users#show
#                           PATCH  /users/:id(.:format)                                                                     users#update
#                           PUT    /users/:id(.:format)                                                                     users#update
#                           DELETE /users/:id(.:format)                                                                     users#destroy
#                     goals GET    /goals(.:format)                                                                         goals#index
#                           POST   /goals(.:format)                                                                         goals#create
#                  new_goal GET    /goals/new(.:format)                                                                     goals#new
#                 edit_goal GET    /goals/:id/edit(.:format)                                                                goals#edit
#                      goal GET    /goals/:id(.:format)                                                                     goals#show
#                           PATCH  /goals/:id(.:format)                                                                     goals#update
#                           PUT    /goals/:id(.:format)                                                                     goals#update
#                           DELETE /goals/:id(.:format)                                                                     goals#destroy
#               new_session GET    /session/new(.:format)                                                                   sessions#new
#              edit_session GET    /session/edit(.:format)                                                                  sessions#edit
#                   session GET    /session(.:format)                                                                       sessions#show
#                           PATCH  /session(.:format)                                                                       sessions#update
#                           PUT    /session(.:format)                                                                       sessions#update
#                           DELETE /session(.:format)                                                                       sessions#destroy
#                           POST   /session(.:format)                                                                       sessions#create
#                      root GET    /                                                                                        users#new
#        rails_service_blob GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
# rails_blob_representation GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
#        rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
# update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
#      rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create

Rails.application.routes.draw do
  resources :users
  resources :goals
  resource :session

  root to: "users#new"
end
