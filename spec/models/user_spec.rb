require 'spec_helper'

describe User do
  describe "validation" do
    describe "name" do
      context "is nil" do
        it { expect(build(:user, name: nil)).to have(1).error_on(:name) }
      end
    end

    describe "uid" do
      context "is nil" do
        it { expect(build(:user, uid: nil)).to have(1).error_on(:uid) }
      end

      context "is not uniq" do
        before { create(:user, uid: 1) }

        it { expect(build(:user, uid: 1)).to have(1).error_on(:uid) }
      end
    end

    describe "nickname" do
      context "is nil" do
        it { expect(User.new).to have(1).error_on(:nickname) }
      end

      context "is not uniq" do
        before { create(:user, nickname: "nadia") }

        it { expect(build(:user, nickname: "nadia")).to have(1).error_on(:nickname) }
      end
    end
  end

  describe "#create_with_omniauth" do
    let(:auth) do
      {
        "uid" => "1234",
        "info" => {
          "name" => "name",
          "nickname" => "nickname",
          "image" => "image"
        }
      }
    end

    it "created user" do
      expect { User.create_with_omniauth(auth) }.to change { User.count }.from(0).to(1)
    end

    it "returned user object" do
      expect(User.create_with_omniauth(auth)).to be_instance_of User
    end
  end
end
