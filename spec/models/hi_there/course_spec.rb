require 'rails_helper'

module HiThere
  RSpec.describe Course, type: :model do  
    it "fails when name is invalid" do
      expect(build(:course, name: 'has many spacs')).to_not be_valid
      expect(build(:course, name: 'has-many-hyphens')).to_not be_valid
      expect(build(:course, name: 'has_underscores')).to be_valid
    end
  end
end
