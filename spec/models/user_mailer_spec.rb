require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  describe '#welcome_email' do
    let(:user) { Fabricate(:user, name: 'test',
                                  email: 'test@email.com',
                                  phone: '123-456-789',
                                  password: 'password')}
    let(:mail) { described_class.welcome_email(user).deliver_now }

    it 'renders the subject' do
      expect(mail.subject).to eq('Welcome to Stack')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(["cloneyislandmailer@gmail.com"])
    end

    it 'has the link to the site in the body' do
      expect(mail.body.raw_source.include?('https://calm-crag-26774.herokuapp.com')).to eq (true)
    end
  end
  describe '#blocked_email' do
    let(:user) { Fabricate(:user, name: 'test',
                                  email: 'test@email.com',
                                  phone: '123-456-789',
                                  password: 'password')}
    let(:mail) { UserMailer.blocked_email(user).deliver_now }

    it 'renders the subject' do
      expect(mail.subject).to eq('Ban Notice')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(["cloneyislandmailer@gmail.com"])
    end
  end
  describe '#unblocked_email' do
    let(:user) { Fabricate(:user, name: 'test',
                                  email: 'test@email.com',
                                  phone: '123-456-789',
                                  password: 'password')}
    let(:mail) { described_class.unblocked_email(user).deliver_now }

    it 'renders the subject' do
      expect(mail.subject).to eq('Welcome Back')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(["cloneyislandmailer@gmail.com"])
    end
  end
end
