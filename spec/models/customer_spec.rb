require 'rails_helper'

RSpec.describe Customer, type: :model do
  context 'associations' do
    it { should belong_to(:user).class_name('User') }
  end
  context 'attributes' do
    it 'has expected attributes' do
      typical_customer = create(:customer)
      expect(typical_customer.attribute_names).to include('id')
    end
  end
end
