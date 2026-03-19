# frozen_string_literal: true

module Taskflow
  module Concerns
    module User
      module Validations
        extend ActiveSupport::Concern

        included do
          validates :name, :last_name, :cpf, :email, :phone_number, presence: true
          validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
          validates :name, :last_name, length: { minimum: 3 }
          validates :cpf, :email, :phone_number, uniqueness: true
          validate :valid_cpf
        end

        private

        def valid_cpf
          errors.add(:cpf, 'cpf invalid') unless CPF.valid?(self.cpf)
        end
      end
    end
  end
end
