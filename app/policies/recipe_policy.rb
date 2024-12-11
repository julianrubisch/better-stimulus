class RecipePolicy
  attr_reader :user, :page

  # TODO refactor to use recipe model
  def initialize(user, page)
    @user = user
    @page = page
  end

  def show?
    !page.data["auth"] || user&.patron?
  end

  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
