module Groups
   class Create < Core::Service
     def call(params:, user:)
       @params = params
       @user = user
       group.user_id = user.id
       group.save ? Success(group) : Failure(group.errors)
     end
 
     private
 
     attr_reader :params, :user
 
     def group
       @group ||= Group.new(params)
     end
   end
 end