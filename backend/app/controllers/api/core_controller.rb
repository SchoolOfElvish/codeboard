# frozen_string_literal: true

module Api
  class BaseController < ApplicationController
    before_action :authenticate!, :set_locale
  end
end
