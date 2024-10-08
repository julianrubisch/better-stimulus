class TemplatesController < ApplicationController
  def show
    @code = Cookbook::Recipe.find("cookbook/#{params[:category]}/#{params[:recipe]}").code

    respond_to do |format|
      format.text
    end
  rescue Module::DelegationError
    raise ActiveRecord::RecordNotFound.new("The recipe you requested couldn't be found.")
  end
end
