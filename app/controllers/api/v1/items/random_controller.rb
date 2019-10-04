class Api::V1::Items::RandomController < ApplicationController

  def show
    ids = Item.pluck(:id).shuffle
    render json: ItemSerializer.new(Item.find(ids[0]))
  end

end
