require 'rails_helper'

RSpec.describe UserPolicy do
  subject(:policy) { described_class.new(current_user, User) }

  describe '#index?' do
    context 'when the user is an admin' do
      let(:current_user) { build(:user, :admin) }

      it 'permits access' do
        expect(policy.index?).to be true
      end
    end

    context 'when the user is not an admin' do
      let(:current_user) { build(:user) }

      it 'denies access' do
        expect(policy.index?).to be false
      end
    end
  end

  describe 'scope' do
    let!(:admin) { create(:user, :admin) }
    let!(:user) { create(:user) }

    it 'returns all users for an admin' do
      expect(Pundit.policy_scope!(admin, User)).to contain_exactly(admin, user)
    end

    it 'returns no users for a non-admin' do
      expect(Pundit.policy_scope!(user, User)).to be_empty
    end
  end
end
