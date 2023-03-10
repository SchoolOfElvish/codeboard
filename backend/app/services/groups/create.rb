# frozen_string_literal: true

module Groups
  class Create < Core::Service
    def call(params:, user:)
      @params = params
      @user = user
      create_group
    end

    private

    attr_reader :params, :user

    def create_group
      group.author_id = user.id
      group.save ? Success(group) : Failure(group.errors)
    end

    def group
      @group ||= Group.new(params)
    end
  end
end
