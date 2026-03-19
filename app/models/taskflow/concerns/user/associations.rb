# frozen_string_literal: true

module Taskflow
  module Concerns
    module User
      module Associations
        extend ActiveSupport::Concern
        included do
          has_secure_password
        end
      end
    end
  end
end
