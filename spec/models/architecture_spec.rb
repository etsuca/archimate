require 'rails_helper'

RSpec.describe Architecture, type: :model do
  let(:user) { create(:user) }

  describe 'validations' do
    it 'validates presence of name' do
      architecture = build(:architecture, user:, name: nil)
      expect(architecture).not_to be_valid
      expect(architecture.errors[:name]).to include('を入力してください')
    end

    it 'validates maximum length of name' do
      architecture = build(:architecture, user:, name: 'a' * 256)
      expect(architecture).not_to be_valid
      expect(architecture.errors[:name]).to include('は255文字以内で入力してください')
    end

    it 'validates format of name' do
      architecture = build(:architecture, user:, name: 'Invalid@Name')
      expect(architecture).not_to be_valid
      expect(architecture.errors[:name]).to include('に使用できない文字が含まれています')
    end

    it 'validates presence of location' do
      architecture = build(:architecture, user:, location: nil)
      expect(architecture).not_to be_valid
      expect(architecture.errors[:location]).to include('を入力してください')
    end

    it 'validates maximum length of location' do
      architecture = build(:architecture, user:, location: 'a' * 256)
      expect(architecture).not_to be_valid
      expect(architecture.errors[:location]).to include('は255文字以内で入力してください')
    end

    it 'validates maximum length of architect' do
      architecture = build(:architecture, user:, architect: 'a' * 256)
      expect(architecture).not_to be_valid
      expect(architecture.errors[:architect]).to include('は255文字以内で入力してください')
    end

    it 'validates format of architect' do
      architecture = build(:architecture, user:, architect: 'Invalid@Architect')
      expect(architecture).not_to be_valid
      expect(architecture.errors[:architect]).to include('に使用できない文字が含まれています')
    end

    it 'validates maximum length of description' do
      architecture = build(:architecture, user:, description: 'a' * 65_536)
      expect(architecture).not_to be_valid
      expect(architecture.errors[:description]).to include('は65535文字以内で入力してください')
    end

    it 'validates maximum number of images' do
      architecture = build(:architecture, user:)
      11.times do
        architecture.images.attach(io: Rails.root.join('spec/fixtures/sample.jpg').open, filename: 'sample.jpg', content_type: 'image/jpeg')
      end
      expect(architecture).not_to be_valid
      expect(architecture.errors[:images]).to include('は10枚以内で入力してください')
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:tag_architecture_relationships).dependent(:destroy) }
    it { is_expected.to have_many(:tags).through(:tag_architecture_relationships).dependent(:destroy) }
    it { is_expected.to have_many(:likes).dependent(:destroy) }
  end

  describe 'enums' do
    it { is_expected.to define_enum_for(:open_range).with_values(unpublish: 0, publish: 1) }
    it { is_expected.to define_enum_for(:experience).with_values(possible: 0, impossible: 1) }
  end

  describe '.not_by' do
    it 'returns architecture not created by the given user' do
      architecture1 = create(:architecture, user:)
      architecture2 = create(:architecture)

      result = Architecture.not_by(user)

      expect(result).to include(architecture2)
      expect(result).not_to include(architecture1)
    end
  end

  describe '#by?' do
    it 'returns true if the architecture is created by the given user' do
      architecture = create(:architecture, user:)

      expect(architecture.by?(user)).to be(true)
    end

    it 'returns false if the architecture is not created by the given user' do
      architecture = create(:architecture)

      expect(architecture.by?(user)).to be(false)
    end
  end
end
