# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ApplicationController' do
  describe 'set_local' do
    let(:user) { create(:user) }
    let(:headers) { auth_header_for(user) }
    let(:russian_locale) { { 'HTTP_ACCEPT_LANGUAGE' => 'ru-RU' } }

    it 'set default locale' do
      get('/api/v1/users/me', headers:)
      expect(I18n.locale).to eq(I18n.default_locale)
    end

    it 'set russian locale' do
      get('/api/v1/users/me', headers: headers.merge(russian_locale))
      expect(I18n.locale).to eq(:ru)
    end
  end
end
