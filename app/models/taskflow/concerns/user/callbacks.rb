# frozen_string_literal: true
module Taskflow
  module Concerns
    module User
      module Callbacks
        extend ActiveSupport::Concern

        included do
          before_validation :clean_attributes
        end

        private
        def clean_attributes
          self.cpf = clean_attribute(self.cpf)
          self.phone_number = clean_attribute(self.phone_number)
        end

        def clean_attribute(attribute)
          attribute.present? ? attribute.gsub(/[^0-9]/, '') : nil
        end

      end
    end
  end
end
