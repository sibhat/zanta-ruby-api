require 'rails_helper'

RSpec.describe User, type: :model do
  context 'attributes' do
    it 'has expected attributes' do
      typical_user = create(:user)
      expect(typical_user.attribute_names).to include('email', 'name')
    end
  end
end
