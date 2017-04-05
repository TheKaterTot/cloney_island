require 'rails_helper'

feature 'admin deactivates a user' do
  attr_reader :admin, :question, :user

  before(:each) do
    @admin    = Fabricate(:user)
    @admin.roles.create(name: 'admin')
    @user     = User.create(name:'test',
                            email: 'test',
                            phone: '1',
                            password: 'test')
    user.roles.create(name: 'registered_user')
    @question = Fabricate(:question, user: user)
    Fabricate(:role, name: 'blocked_user')
  end
  scenario 'admin visits question page and deactivates user' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit question_path(question)

    click_button "Deactivate User"
    expect(user.roles.count).to eq(1)
    expect(user.roles[0][:name]).to eq('blocked_user')
  end

  scenario 'admin can deactivate another admin' do
    user.roles.create(name: 'admin')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    question2 = Fabricate(:question, user: admin)

    visit question_path(question)

    click_button "Deactivate User"
    expect(user.roles.count).to eq(1)
    expect(user.roles[0][:name]).to eq('blocked_user')
  end

  scenario 'admin can reactivate a blocked user' do
    user.roles.create(name: 'blocked_user')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    question2 = Fabricate(:question, user: admin)

    visit question_path(question)

    click_button "Reactivate User"
    expect(user.roles.count).to eq(1)
    expect(user.roles[0][:name]).to eq('registered_user')
  end

  scenario 'admin cannot deactivate self' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    question2 = Fabricate(:question, user: admin)

    visit question_path(question2)

    expect(page).to_not have_css('#deactivate-user-button')
  end

  scenario 'user cannot find deactivate user button' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    question2 = Fabricate(:question, user: admin)

    visit question_path(question2)

    expect(page).to_not have_css('#deactivate-user-button')
  end
end
