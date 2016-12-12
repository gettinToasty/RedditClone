require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_length_of(:password).is_at_least(6) }

  end

  describe "associations" do
    it { should have_many(:subs) }
    it { should have_many(:votes) }
    it { should have_many(:comments) }
  end

  describe '#is_password?' do
    it "checks if a password matches" do
      user = User.create(username: "MavisBeacon",password: "123456")

      expect(user.is_password?("123456")).to be(true)
    end

    it "rejects an incorrect password" do
      user = User.create(username: "MavisBeacon",password: "123456")

      expect(user.is_password?("133456")).to be(false)
    end
  end

  describe '#reset_session_token' do
    it "resets the user's session_token" do
      user = User.create(username: "MavisBeacon",password: "123456")
      tok = user.session_token
      user.reset_session_token

      expect(user.session_token).to_not eq(tok)
    end


  end

  describe '::find_by credentials' do
    it "does not find an invalid user" do
      expect(User.find_by_credentials("MavisBeacon", "")).to be(nil)
    end

    it "returns a valid user" do
      user = User.create(email: "MavisBeacon", username: "MavisBeacon", password: "123456")

      expect(User.find_by_credentials("MavisBeacon", "123456")).to eq(user)
    end
  end
end
