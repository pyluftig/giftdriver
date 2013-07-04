require 'spec_helper'

describe User do

  let(:user) { FactoryGirl.build(:user) }

  context "user associations" do
    it { should validate_presence_of :full_name}
    it { should validate_presence_of :email}
    it { should validate_presence_of :zipcode}
    it { should validate_presence_of :password}
    it { should validate_uniqueness_of :email}
    it { should have_many(:drives) }
  end
end
