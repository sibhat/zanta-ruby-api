require 'rails_helper'

RSpec.describe Business, type: :model do
  context 'associations' do
    it { should belong_to(:user).class_name('User') }
  end
  context 'attributes' do
    it 'has expected attributes' do
      typical_business = create(:business)
      expect(typical_business.attribute_names).to include('business_name',
                                                          'location', 'on_time_delivery')
    end
  end
end
