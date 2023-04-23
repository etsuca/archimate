class ArchitectureController < ApplicationController
  def index
    @architecture = Architecture.all.includes(:user, :open_range).order(created_at: :desc)
  end
end
