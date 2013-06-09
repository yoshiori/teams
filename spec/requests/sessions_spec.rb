require 'spec_helper'

describe "Sessions" do

  let(:uid) { "12345" }

  before do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
        "uid" => uid,
        "info" => {
          "name" => "name",
          "nickname" => "nickname",
          "image" => "image"
        }
      })
  end

  describe "GET /auth/github" do
    context "new user" do
      it "auth & create user" do
        expect {
          get "/auth/github"
          follow_redirect!
        }.to change{ User.count }.from(0).to(1)
        expect(response).to redirect_to root_path
        expect(session["user_id"]).to_not be_nil
      end
    end

    context "known user" do
      before { create(:user, uid: uid)}

      it "auth user" do
        expect {
          get "/auth/github"
          follow_redirect!
        }.to_not change{ User.count }.from(0).to(1)
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "GET /logout" do
    it "delete session" do
      expect {
        get "/auth/github"
        follow_redirect!
      }.to change{ User.count }.from(0).to(1)
      expect(response).to redirect_to root_path
      expect(session["user_id"]).to_not be_nil
      get "/logout"
      expect(session["user_id"]).to be_nil
      end
  end
end
