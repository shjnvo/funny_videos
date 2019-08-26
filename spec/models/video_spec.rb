require 'rails_helper'

RSpec.describe Video, type: :model do
  let(:video) { create :video }
  let(:user) { create :user, email: "test@gmail.com" }
  let(:likeable) { create :likeable, user_id: user.id, video_id: video.id}

  subject { video }

  describe 'check validation' do
    it 'validate' do
      aggregate_failures do
        is_expected.to be_valid
        is_expected.to validate_uniqueness_of :uuid
      end
    end
  end

  context 'association' do
    it { should belong_to(:user) }
  end

  context 'check method #action_by' do
    it 'have user like' do
      expect(likeable.user).to eq user
      expect(video.action_by(user).present?).to be_truthy
    end
    it 'not have user like' do
      expect(video.action_by(video.user).present?).to be_falsey
    end
  end
end
