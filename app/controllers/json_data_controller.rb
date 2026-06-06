class JsonDataController < ApplicationController
  before_action :authenticate_user!

  def users_buildings
    # 都道府県制覇マップ用データ
    users_buildings = current_user.buildings
    render json: users_buildings
  end
end
