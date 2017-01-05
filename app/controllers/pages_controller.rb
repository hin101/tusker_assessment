require 'httparty'

class PagesController < ApplicationController
  def boxes
    response = HTTParty.get('http://tuskermarvel.com/boxes.json')
    @boxes = JSON.parse(response.body)

    logger.info(@boxes)

    @boxes.each do |b|
      b["contents"].each do |bc|
        logger.info("line: #{bc}")
      end
    end
  end
end