require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create :user }

  subject { user }

  describe 'check validation' do
    it 'validate' do
      aggregate_failures do
        is_expected.to be_valid
        is_expected.to validate_presence_of :email
        is_expected.to validate_uniqueness_of :email
        is_expected.to validate_length_of(:password_digest).is_at_least(6)
        is_expected.to_not allow_values('').for(:password_digest)
      end
    end
  end

  context 'association' do
    it { should have_many(:videos) }
  end
end
