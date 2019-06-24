require 'spec_helper'

describe User do
  before do 
    @user = User.create(:name => "Test", :email => "test@gmail.com",
          password: "test123", password_confirmation: "test123")
  end

  subject { @user }

  it { should be_valid }

  describe "when name is not present" do
    before { @user.name = nil }
    it { should_not be_valid }
  end

  describe "when name is invalid" do
    before { @user.name = "   " }
    it { should_not be_valid }
  end

  describe "when email not present" do
    before { @user.email = nil }
    it { should_not be_valid }
  end

end
