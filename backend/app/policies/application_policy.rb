class ApplicationPolicy < ActionPolicy::Base
  include Dry::Monads::Result::Mixin
end
