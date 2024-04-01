class SimilarScraper
  include Mongoid::Document
  include Mongoid::Timestamps
  field :url, type: String
  field :scraped_data, type: Json

  def scrape_and_save
    html = open(url)
    doc = Nokogiri::HTML(html)

    url = doc.css(".wa-overview__title").text
    category = doc.at_css('.app-company-info__row:nth-child(6) .app-company-info__link').text.strip
    total_visits = doc.at_css("p.engagement-list__item-name[data-test='total-visits'] + p.engagement-list__item-value").text
    last_month_change = doc.at_css("p.engagement-list__item-name[data-test='total-visits-change'] + p.engagement-list__item-value").text
    avg_visit_duration = doc.at_css("p.engagement-list__item-name[data-test='avg-visit-duration'] + p.engagement-list__item-value").text
    pages_per_visit = doc.at_css("p.engagement-list__item-name[data-test='pages-per-visit'] + p.engagement-list__item-value").text
    bounce_rate = doc.at_css("p.engagement-list__item-name[data-test='bounce-rate'] + p.engagement-list__item-value").text

    top_countries_div = doc.at_css(".wa-legend.wa-geography__legend")
    top_countries = []

    top_countries_div.css(".wa-geography__country").each do |country_div|
      country_name = country_div.at_css(".wa-geography__country-name").text
      top_countries << country_name
    end

    age_distribution = {}

    age_chart_div = doc.at_css("div.wa-demographics__age-chart")
    age_labels = age_chart_div.css("g.highcharts-data-labels.highcharts-series-0.highcharts-column-series.highcharts-tracker text")

    age_ranges = ["18-24", "25-34", "35-44", "45-54", "55-64", "65+"]

    age_labels.each_with_index do |label, index|
      age_range = age_ranges[index]
      percentage = label.at_css("tspan.wa-demographics__age-data-label").text
      age_distribution[age_range] = percentage
    end

    female_li = doc.at_css("li.wa-demographics__gender-legend-item--female")
    female_percentage = female_li.at_css(".wa-demographics__gender-legend-item-value").text
    male_li = doc.at_css("li.wa-demographics__gender-legend-item--male")
    male_percentage = male_li.at_css(".wa-demographics__gender-legend-item-value").text
    gender_distribution = {female: female_percentage, male: male_percentage}

    data = {url: url, category: category, total_visits: total_visits, last_month_change: last_month_change, avg_visit_duration: avg_visit_duration, pages_per_visit: pages_per_visit, bounce_rate: bounce_rate, top_countries: top_countries, gender_distribution: gender_distribution, age_distribution: age_distribution}

    self.scraped_data = data

    save
  rescue StandardError => e
    Rails.logger.error("Error scraping and saving data: #{e.message}")
    false
  end
end
