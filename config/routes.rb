Rails.application.routes.draw do
  post '/save_info', to: 'similar_scraper#save_info'
  post '/get_info', to: 'similar_scraper#get_info'
end
