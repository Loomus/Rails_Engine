class Api::V1::Tansactions::RandomController < ApplicationController

  def show
    ids = Tansaction.pluck(:id).shuffle
    render json: TansactionSerializer.new(Tansaction.find(ids[0]))
  end

end
