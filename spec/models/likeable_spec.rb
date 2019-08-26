require 'rails_helper'

RSpec.describe Likeable, type: :model do
  let(:user) { create :user, email: "test@gmail.com" }
  let(:likeable) { create :likeable, user_id: user.id }
  let(:video) { create :video }

  subject { likeable }

  describe 'check validation' do
    it 'validate' do
      aggregate_failures do
        is_expected.to be_valid
        is_expected.to define_enum_for :status
        is_expected.to validate_presence_of :status
        is_expected.to validate_uniqueness_of(:video_id).scoped_to(:user_id).with_message('One User only like one video!!!')
      end
    end
  end
end
