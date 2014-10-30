# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)      not null
#  email           :string(255)      not null
#  name            :string(255)
#  password_digest :string(255)      not null
#  created_at      :datetime
#  updated_at      :datetime
#

require 'rails_helper'
require 'necessary_and_unique_attribute'

RSpec.describe User, :type => :model do

  describe "validates" do
    describe "username" do
      it_behaves_like "a necessary and unique attribute", :user, :username
    end

    describe "email" do
      it_behaves_like "a necessary and unique attribute", :user, :username
      it do
        should allow_value('csj.nyc@gmail.com', 'areallyw31RD3m811@anjlj.com')
          .for(:email)
      end
      it { should_not allow_value('email;address@email.com').for(:email) }
      it { should_not allow_value('whatisthi@s').for(:email) }
    end

    describe "name" do
      it "should default to 'Dork Dorkly'" do
        expect(create(:user).name).to eq("Dork Dorkly")
      end
    end

    describe "password digest" do
      it { should validate_presence_of(:password_digest) }
    end

    describe "password" do
      it { should ensure_length_of(:password).is_at_least(6) }
      it { should allow_value(nil).for(:password) }
    end
  end

  describe "authorizes" do
    let(:user) { create(:user) }

    it "does not reveal password" do
      expect{ user.password }.to raise_error(NoMethodError)
    end

    it "checks if the password matches for the user" do
      expect(user.is_password?('secret')).to be true
    end

    describe "User::find_by_credentials" do
      it "returns the user if the username and password match" do
        found_user = User.find_by_credentials({
          username: user.username,
          password: "secret"
        })
        expect(found_user).to eq(user)
      end

      it "returns nil if the username is not found" do
        found_user = User.find_by_credentials({username: "badname", password: "secret"})
        expect(found_user).to be_nil
      end

      it "returns nil if the password is incorrect" do
        found_user = User.find_by_credentials({username: "csj", password: "letmein"})
        expect(found_user).to be_nil
      end
    end
  end

  describe "associates" do
    it { should have_many(:sessions) }
    it { should have_many(:created_games) }
    it { should have_many(:rounds) }
  end

end
