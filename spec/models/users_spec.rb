require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  let(:architecture) { create(:architecture) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(user).to be_valid
    end

    it 'is not valid without a name' do
      user = build(:user, name: nil)
      expect(user).not_to be_valid
      expect(user.errors[:name]).to include('を入力してください')
    end

    it 'is not valid with a name that exceeds the maximum length' do
      user = build(:user, name: 'a' * 256)
      expect(user).not_to be_valid
      expect(user.errors[:name]).to include('は255文字以内で入力してください')
    end

    it 'is not valid without an email' do
      user.email = nil
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include('を入力してください')
    end

    it 'is not valid with a duplicate email address' do
      duplicate_user = user.dup
      duplicate_user.email = user.email.upcase
      user.save
      expect(duplicate_user).not_to be_valid
      expect(duplicate_user.errors[:email]).to include('はすでに存在します')
    end
  end

  describe 'associations' do
    it { should have_many(:architecture).dependent(:destroy) }
    it { should have_many(:likes).dependent(:destroy) }
    it { should have_many(:like_architecture).through(:likes).source(:architecture) }
  end

  describe '#find_for_oauth' do
    let(:auth) do
      OmniAuth::AuthHash.new(
        provider: 'google_oauth2',
        uid: '123456',
        info: { email: 'user@example.com' }
      )
    end

    context 'when a user with the same provider and uid exists' do
      it 'returns the existing user' do
        existing_user = create(:user, provider: auth.provider, uid: auth.uid)
        found_user = User.find_for_oauth(auth)
        expect(found_user).to eq(existing_user)
      end
    end

    context 'when a user with the same provider and uid does not exist' do
      it 'creates a new user' do
        new_user = User.find_for_oauth(auth)
        expect(new_user.persisted?).to be true
        expect(new_user.provider).to eq(auth.provider)
        expect(new_user.uid).to eq(auth.uid)
        expect(new_user.email).to eq(auth.info.email)
        expect(new_user.name).to eq('ゲストユーザー')
      end
    end
  end

  describe '#own?' do
    it 'returns true if the user owns the object' do
      object = create(:architecture, user:)
      expect(user.own?(object)).to eq(true)
    end

    it 'returns false if the user does not own the object' do
      other_user = create(:user)
      object = create(:architecture, user: other_user)
      expect(user.own?(object)).to eq(false)
    end
  end

  describe '#like' do
    it 'adds an architecture to the liked architecture' do
      user.like(architecture)
      expect(user.like_architecture).to include(architecture)
    end
  end

  describe '#unlike' do
    it 'removes an architecture from the liked architecture' do
      user.like(architecture)
      user.unlike(architecture)
      expect(user.like_architecture).not_to include(architecture)
    end
  end

  describe '#like?' do
    it 'returns true if the user likes the architecture' do
      user.like(architecture)
      expect(user.like?(architecture)).to be(true)
    end

    it 'returns false if the user does not like the architecture' do
      expect(user.like?(architecture)).to be(false)
    end
  end

  describe '#update_without_password' do
    it 'updates user attributes without changing the password' do
      params = { name: 'New Name', email: 'new_email@example.com' }
      user.update_without_password(params)
      user.reload
      expect(user.name).to eq('New Name')
      expect(user.email).to eq('new_email@example.com')
    end

    it 'does not change the password when password params are blank' do
      old_password = user.encrypted_password
      params = { name: 'New Name', email: 'new_email@example.com', password: '', password_confirmation: '' }
      user.update_without_password(params)
      user.reload
      expect(user.encrypted_password).to eq(old_password)
    end
  end
end
