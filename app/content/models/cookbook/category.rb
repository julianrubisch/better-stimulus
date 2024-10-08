class Cookbook::Category < ActiveHash::Base
  self.data = [
    {name: "DOM Manipulation", slug: "dom-manipulation"},
  ]

  def to_s
    name
  end
end
