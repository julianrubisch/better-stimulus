class TemplatesController < ApplicationController
  after_action :track_download

  def show
    recipe = Cookbook::Recipe.find("cookbook/#{params[:category]}/#{params[:recipe]}")
    @code = recipe.code

    if recipe.auth && !Current.user&.patron?
      head :forbidden
      return
    end

    respond_to do |format|
      format.text
    end
  rescue Module::DelegationError
    raise ActiveRecord::RecordNotFound.new("The recipe you requested couldn't be found.")
  end

  private

  def track_download
    ahoy.track "Downloaded template", "cookbook/#{params[:category]}/#{params[:recipe]}"
  end
end
