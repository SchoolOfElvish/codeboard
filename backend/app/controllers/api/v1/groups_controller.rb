module Api
    module V1
        class GroupsController < ApplicationController

            def new
               @group = Group.new
            end

            def create
                @group = Group.new (group_params.merge(user_id: current_user.id))
            end

            def save
                @group.save
            end

            private

            attr_reader :params, :group

                def groups_params
                    params.require(:group).permit(:name, :user_id)
                end
            end       

        end
    end
end
