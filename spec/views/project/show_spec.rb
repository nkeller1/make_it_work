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

  it "can count the number of projects" do
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

    contestant_1.projects << furniture_challenge.projects
    contestant_2.projects << recycled_material_challenge.projects

    visit "/projects/#{project_1.id}"

    expect(page).to have_content("Number of Contestants: #{project_1.contestants.length}")
  end

  it "can see the average years of experience for the contestants that worked on that project" do
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

    expect(page).to have_content("Average Age of Contestants: #{project_1.contestants.average(:age)}")
    expect(page).to_not have_content("Average Age of Contestants: #{project_2.contestants.average(:age)}")
  end
end
