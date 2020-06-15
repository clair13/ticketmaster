require 'spec_helper'

RSpec.feature "Project managers can edit existing projects" do

  let(:user) { FactoryBot.create(:user) }
  let(:project) { FactoryBot.create(:project, name: "TextMate 2") }

  before do
    login_as(user)
    assign_role!(user, :manager, project)

    visit "/"
    click_link "TextMate 2"
    click_link "Edit Project"
  end

  scenario "Updating a project" do
    fill_in "Name" ,with: "TextMate 2 beta"
    click_button "Update Project"

    expect(page).to have_content("Project has been updated.")
  end

  scenario "Updating a project with invalid attributes" do
    fill_in "Name", with: ""
    click_button "Update Project"

    expect(page).to have_content("Project has not been updated")
  end
end