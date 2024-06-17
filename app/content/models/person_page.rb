class PersonPage < Sitepress::Model
  collection glob: "people/*.html*"
  data :name, :github, :title, :twitter

  def github_url
    "https://github.com/#{github}"
  end

  def github_avatar_url
    "#{github_url}.png"
  end

  def twitter_url
    "https://twitter.com/#{twitter}"
  end
end
