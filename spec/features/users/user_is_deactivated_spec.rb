require 'rails_helper'

feature 'user is deactivated' do
  attr_reader :user, :question, :answer

  before(:each) do
    @user     = User.create(name:'test',
                            email: 'test',
                            phone: '1',
                            password: 'test')
    user.roles.create(name: 'blocked_user')
    @question = Fabricate(:question, user: user)
    @answer   = Fabricate(:answer, question: question)
  end

  scenario 'deactivated user can view a question' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit question_path(question)

    within("#question-title") do
      expect(page).to have_content(question.title)
    end

    within("#question-body") do
      expect(page).to have_content(question.body)
    end
    expect(current_path).to eq(question_path(question))
    within(".question-answers") do
      expect(page).to have_content(answer.body)
    end
  end

    scenario 'deactivated user can visit root' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      category        = Fabricate(:category)

      visit root_path

      within('.recent-activity') do
        expect(page).to have_content('Recent Activity')
        expect(page).to have_content(question.title)
      end

      within('.categories') do
        expect(page).to have_content('Categories')
        expect(page).to have_content(category.name)
      end
    end

    scenario 'deactivated user can log in' do

      visit root_path

      click_link 'Login'

      expect(current_path).to eq(login_path)

      fill_in "Name", with: "#{user.name}"
      fill_in "Password", with: "#{user.password}"

      click_button "Login"
      expect(current_path).to eq(user_path(user))
    end

    scenario 'deactivated user can edit their profile' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit user_path(user)

      within("#user-info-table") do
        click_on "Edit User Profile"
      end

      expect(current_path).to eq(edit_user_path(user))

      fill_in "Email", with: "no@no.com"
      fill_in "Phone", with: "123-456-7890"

      click_on("Save")

      expect(current_path).to eq(user_path(user))

      within("#user-info-table") do
        expect(page).to have_content("no@no.com")
        expect(page).to have_content("123-456-7890")
      end
    end

    scenario 'deactivated user can change their password' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      token = Fabricate(:password_token, token: '123',  user: user)

      visit user_path(user)

      expect_any_instance_of(PasswordsController).to receive(:send_token)
      within("#user-info-table") do
        click_on("Change Password")
      end

      expect(current_path).to eq(edit_password_path)

      fill_in "Token", with: "123"
      fill_in "New Password", with: "new_password"
      fill_in "Password Confirmation", with: "new_password"

      click_on "Save"

      expect(current_path).to eq(user_path(user))
      expect(user.reload.authenticate("new_password")).to be_truthy
    end

  scenario 'deactivated user cannot post an answer' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit question_path(question)

    fill_in "Enter text", with: "Dumb question"
    click_button("Submit")


    expect(current_path).to eq(root_path)
    within(".alert-danger") do
      expect(page).to have_content("Your account priveleges have been limited due to your activity")
    end
  end

  scenario 'deactivated user cannot post a comment' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit question_path(question)

    within(".comment-on-question") do
      fill_in "Add Comment", with: "This is an awesome comment"
      click_on "Add Comment"
    end

    expect(current_path).to eq(root_path)
    within(".alert-danger") do
      expect(page).to have_content("Your account priveleges have been limited due to your activity")
    end
  end

  scenario 'deactivated user cannot delete a question' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit question_path(question)


    within("#delete-question") do
      click_on "Delete Question"
    end

    expect(current_path).to eq(root_path)
    within(".alert-danger") do
      expect(page).to have_content("Your account priveleges have been limited due to your activity")
    end

    expect(Question.count).to eq(1)

    within('.recent-activity') do
      expect(page).to have_content('Recent Activity')
      expect(page).to have_content(question.title)
    end
  end

    scenario 'deactivated user cannot post a question' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit root_path

      within("#nav-mobile.left") do
        click_link("Ask Question")
      end

      expect(current_path).to eq(root_path)
      within(".alert-danger") do
        expect(page).to have_content("Your account priveleges have been limited due to your activity")
      end
    end

end
