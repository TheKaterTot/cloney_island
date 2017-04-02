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
  end
  scenario 'admin visits question page and deactivates user' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit question_path(question)
byebug
    click_button "Deactivate User"
    expect(user.roles.count).to eq(1)
    expect(user.roles[0][:name]).to eq('blocked_user')
  end

end
