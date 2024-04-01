class SimilarScraperController < ApplicationController
  def save_info
    url = "https://www.similarweb.com/pt/website/#{params[:url]}"
    scraper = SimilarScraper.new(url: url)
    if scraper.scrape_and_save
      render json: { message: 'Data saved successfully' }, status: :created
    else
      render json: { error: 'Failed to save data' }, status: :unprocessable_entity
    end
  end

  def get_info
    url = "https://www.similarweb.com/pt/website/#{params[:url]}"
    scraper = SimilarScraper.find_by(url: url)
    if scraper
      render json: scraper.scraped_data
    else
      head :not_found
    end
  end
end
