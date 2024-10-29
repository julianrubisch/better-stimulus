class Cookbook::Category < ActiveHash::Base
  self.data = [
    {name: "Client/Server Interactions", slug: "client-server"},
    {name: "DOM Manipulation", slug: "dom-manipulation"},
    {name: "Theming", slug: "theming"},
  ]

  def to_s
    name
  end
end
