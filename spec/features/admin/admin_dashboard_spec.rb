require 'rails_helper'

feature 'admin show page' do
  attr_reader :thing1,
              :thing2,
              :thing3,
              :good,
              :admin
  before(:each) do
    @thing1 = Fabricate(:user, reputation: -50, name: 'thing1')
    thing1.user_roles.delete_all
    thing1.roles.create(name: 'registered_user')
    @thing2 = Fabricate(:user, reputation: -50, name: 'thing2')
      thing2.roles.create(name: 'registered_user')
    @thing3 = Fabricate(:user, reputation: -400, name: 'thing3')
      thing3.user_roles.delete_all
      thing3.roles.create(name: 'blocked_user')
    @good   = Fabricate(:user, reputation: 200)
      good.roles.create(name: 'registered_user')
    @admin = Fabricate(:user)
      admin.roles.create(name: 'admin')
  end
  scenario 'admin has users to deactivate listed on the show page' do
    login(admin.name)
    visit user_path(admin)

    expect(page).to have_css('#users-to-deactivate')
 
    within('#users-to-deactivate') do
      expect(page).to have_content('thing1')
      expect(page).to have_content('thing2')
      expect(page).to_not have_content('thing3')
      expect(page).to_not have_content('good')
      expect(page).to have_button('Deactivate User')
    end
  end
end
