require 'rails_helper'
RSpec.describe "add new contestant to project" do
xit "add a new contests" do
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

  project_1 = furniture_challenge.projects.create(name: "Upholstery Tuxedo", material: "Couch")
  project_2 = furniture_challenge.projects.create(name: "Litfit", material: "Lamp")

  contestant_1.projects << [project_1]
  contestant_2.projects << [project_1, project_2]

  visit "/projects/#{project_1.id}"

  expect(page).to have_content("New Contestant Information")

  fill_in :name, with: "Nathan"
  fill_in :age, with: 34
  fill_in :hometown, with: "Jamica"
  fill_in :years_of_experience, with: 45

  click_on "Add Contestant To Project"

  expect(current_path).to eq("/projects/#{project_1.id}")
  expect(page).to have_content("Number of Contestants: #{project_1.contestants.length}")

  visit "/contestants"

  expect(page).to have_content("Nathan")
  expect(page).to have_content("Jamica")
  end
end
