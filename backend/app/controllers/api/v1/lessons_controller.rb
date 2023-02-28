# frozen_string_literal: true

module Api
  module V1
    class LessonsController < ApplicationController
      include Dry::Monads::Result::Mixin
    end
  end
end
