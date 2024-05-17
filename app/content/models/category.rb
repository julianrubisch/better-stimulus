class Category < ActiveHash::Base
  self.data = [
    {name: "Architecture", slug: "architecture"},
    {name: "DOM Manipulation", slug: "dom_manipulation"},
    {name: "Error Handling", slug: "error_handling"},
    {name: "Events", slug: "events"},
    {name: "Integrating Libraries", slug: "integrating-libraries"},
    {name: "Interaction", slug: "interaction"},
    {name: "SOLID", slug: "solid"},
    {name: "With Turbo", slug: "turbo"}
  ]

  def to_s
    name
  end
end
