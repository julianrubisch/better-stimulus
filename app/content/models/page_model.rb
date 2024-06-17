class PageModel < Sitepress::Model
  collection glob: "**/*.html*"
  data :title, :category #, :author

  def author
    PersonPage.find("people/#{data.author}")
  end

  def authors
    data.authors.map do |author|
      PersonPage.find("people/#{author}")
    end
  end
end
