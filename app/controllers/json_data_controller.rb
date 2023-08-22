class JsonDataController < ApplicationController
  def users_architecture
    # 都道府県制覇マップ用データ
    users_architecture = current_user.architecture
    render json: users_architecture
  end
end
