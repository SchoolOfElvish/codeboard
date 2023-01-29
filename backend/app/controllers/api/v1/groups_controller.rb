module Api
    module V1
        class GroupsController < ApplicationController
            def new
               @group = Group.new
            end

            def create
                @group = Group.new (group_params)
            end

            private
                def groups_params
                    params.require(:group).permit(:name, :user_id)

        end
    end
end
