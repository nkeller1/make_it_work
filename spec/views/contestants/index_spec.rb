require 'rails_helper'

RSpec.describe "contestant index page" do
  it "shows all contesnt information" do

    contestant_1 = Contestant.create(name: "Sam",
      age: "12",
      hometown: "Aurora",
      years_of_experience: "2")

    contestant_2 = Contestant.create(name: "Nelly",
      age: "68",
      hometown: "Spain",
      years_of_experience: "400")

    recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
    furniture_challenge = Challenge.create(theme: "Apartment Furnishings", project_budget: 1000)

    recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")
    recycled_material_challenge.projects.create(name: "Boardfit", material: "Cardboard Boxes")

    furniture_challenge.projects.create(name: "Upholstery Tuxedo", material: "Couch")
    furniture_challenge.projects.create(name: "Litfit", material: "Lamp")

    contestant_1.projects << furniture_challenge.projects
    contestant_2.projects << recycled_material_challenge.projects

    visit '/contestants'

    expect(page).to have_content(contestant_1.name)
    expect(page).to have_content(contestant_2.name)
    expect(page).to have_content("Upholstery Tuxedo")
    expect(page).to have_content("Litfit")
    expect(page).to have_content("Projects: Boardfit")
    expect(page).to have_content("News Chic")
  end
end
