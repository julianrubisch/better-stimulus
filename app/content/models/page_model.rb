class PageModel < Sitepress::Model
  collection glob: "**/*.html*"
  data :title, :category
end
