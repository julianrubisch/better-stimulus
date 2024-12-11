class Cookbook::Recipe < Sitepress::Model
  collection glob: "cookbook/**/*.html*"
  data :title, :category, :code, :auth
end
