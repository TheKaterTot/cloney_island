require 'rails_helper'

feature 'admin reactivates a user' do
  attr_reader :admin, :question, :user

  before(:each) do
    @admin    = Fabricate(:user)
    @admin.roles.create(name: 'admin')
    @user     = User.create(name:'test',
                            email: 'test',
                            phone: '1',
                            password: 'test')
    user.roles.create(name: 'blocked_user')
    @question = Fabricate(:question, user: user)
    Fabricate(:role, name: 'registered_user')
  end
  scenario 'admin visits question page and reactivates user' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit question_path(question)

    click_button "Reactivate User"
    expect(user.roles.count).to eq(1)
    expect(user.roles[0][:name]).to eq('registered_user')
  end
end
