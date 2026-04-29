require 'rails_helper'

RSpec.describe Building, type: :model do
  let(:user) { create(:user) }

  describe 'validations' do
    it 'validates presence of name' do
      building = build(:building, user:, name: nil)
      expect(building).not_to be_valid
      expect(building.errors[:name]).to include('を入力してください')
    end

    it 'validates maximum length of name' do
      building = build(:building, user:, name: 'a' * 256)
      expect(building).not_to be_valid
      expect(building.errors[:name]).to include('は255文字以内で入力してください')
    end

    it 'validates format of name' do
      building = build(:building, user:, name: 'Invalid@Name')
      expect(building).not_to be_valid
      expect(building.errors[:name]).to include('に使用できない文字が含まれています')
    end

    it 'validates presence of location' do
      building = build(:building, user:, location: nil)
      expect(building).not_to be_valid
      expect(building.errors[:location]).to include('を入力してください')
    end

    it 'validates maximum length of location' do
      building = build(:building, user:, location: 'a' * 256)
      expect(building).not_to be_valid
      expect(building.errors[:location]).to include('は255文字以内で入力してください')
    end

    it 'validates maximum length of architect' do
      building = build(:building, user:, architect: 'a' * 256)
      expect(building).not_to be_valid
      expect(building.errors[:architect]).to include('は255文字以内で入力してください')
    end

    it 'validates format of architect' do
      building = build(:building, user:, architect: 'Invalid@Architect')
      expect(building).not_to be_valid
      expect(building.errors[:architect]).to include('に使用できない文字が含まれています')
    end

    it 'validates maximum length of description' do
      building = build(:building, user:, description: 'a' * 65_536)
      expect(building).not_to be_valid
      expect(building.errors[:description]).to include('は65535文字以内で入力してください')
    end

    it 'validates maximum number of images' do
      building = build(:building, user:)
      11.times do
        building.images.attach(io: Rails.root.join('spec/fixtures/sample.jpg').open, filename: 'sample.jpg', content_type: 'image/jpeg')
      end
      expect(building).not_to be_valid
      expect(building.errors[:images]).to include('は10枚以内で入力してください。')
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:tag_building_relationships).dependent(:destroy) }
    it { is_expected.to have_many(:tags).through(:tag_building_relationships).dependent(:destroy) }
    it { is_expected.to have_many(:likes).dependent(:destroy) }
  end

  describe 'enums' do
    it { is_expected.to define_enum_for(:open_range).with_values(unpublish: 0, publish: 1) }
    it { is_expected.to define_enum_for(:experience).with_values(possible: 0, impossible: 1) }
  end

  describe '.not_by' do
    it 'returns building not created by the given user' do
      building1 = create(:building, user:)
      building2 = create(:building)

      result = Building.not_by(user)

      expect(result).to include(building2)
      expect(result).not_to include(building1)
    end
  end

  describe '#by?' do
    it 'returns true if the building is created by the given user' do
      building = create(:building, user:)

      expect(building.by?(user)).to be(true)
    end

    it 'returns false if the building is not created by the given user' do
      building = create(:building)

      expect(building.by?(user)).to be(false)
    end
  end
end
