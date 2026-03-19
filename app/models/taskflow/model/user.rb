# frozen_string_literal: true

module Taskflow
  module Model
    class User < ApplicationRecord
      self.table_name = 'dbo.users'

      include Taskflow::Concerns::User::Associations
      include Taskflow::Concerns::User::Validations
      include Taskflow::Concerns::User::Methods
      include Taskflow::Concerns::User::Callbacks
      include Taskflow::Concerns::User::Scopes
    end
  end
end
