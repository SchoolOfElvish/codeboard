class Group::Create

   def call(params:, user:)
    @params = params
    @user = user

    group.user_is = user.id
    group.save
    group
   end
    
    private
    attr_reader :params, :user

   def group
    @group = @group || Group.new(params)
   end


end