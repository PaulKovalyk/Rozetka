# frozen_string_literal: true

RSpec.shared_context 'authorize regular user' do
  let(:current_user) { create(:user) }

  before { sign_in current_user }
end
