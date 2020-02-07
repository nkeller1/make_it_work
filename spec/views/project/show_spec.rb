require 'rails_helper'
RSpec.describe "project show page" do
  it "shows an individual projects information" do
    recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
    furniture_challenge = Challenge.create(theme: "Apartment Furnishings", project_budget: 1000)

    recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")
    recycled_material_challenge.projects.create(name: "Boardfit", material: "Cardboard Boxes")

    furniture_challenge.projects.create(name: "Upholstery Tuxedo", material: "Couch")
    furniture_challenge.projects.create(name: "Litfit", material: "Lamp")

    visit "/projects/#{recycled_material_challenge.projects.first.id}"

    expect(page).to have_content("Name: News Chic")
    expect(page).to have_content("Material: Newspaper")
    expect(page).to have_content("Challenge Theme: Recycled Material")
  end
end


# When I visit a project's show page ("/projects/:id"),
# I see that project's name and material
# And I also see the theme of the challenge that this project belongs to.
# (e.g.    Litfit
#     Material: Lamp Shade
#   Challenge Theme: Apartment Furnishings)
