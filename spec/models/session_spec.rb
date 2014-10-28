require 'rails_helper'
require 'necessary_and_unique_attribute'

RSpec.describe Session, :type => :model do
  describe "validates" do
    describe "user" do
      it { should validate_presence_of(:user) }
    end

    describe "session token" do
      it_behaves_like "a necessary and unique attribute", :session, :session_token
    end
  end

  describe "associates with" do
    describe "user" do
      it { should belong_to(:user) }
    end
  end

  describe "methods" do
    it "generates a unique session token for new sessions" do
      session = Session.create(user: create(:user))
      expect(session.session_token).not_to be_nil
    end

    it "does not overwrite the session_token if the session already has one" do
      user = create(:user)
      Session.create(user: user, session_token: "bad_security")
      fetchedSession = Session.find_by_user_id(user.id)
      expect(fetchedSession.session_token).to eq("bad_security");
    end
  end
end
