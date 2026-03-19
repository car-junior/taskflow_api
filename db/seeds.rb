require "faker"
require "cpf_cnpj"

puts "Limpando dados antigos..."
Taskflow::Model::User.delete_all

puts "Criando usuários de teste..."

cpfs_usados = []

20.times do
  cpf = loop do
    novo = CPF.generate(false) # false = sem formatação (só números)
    break novo unless cpfs_usados.include?(novo)
  end
  cpfs_usados << cpf

  Taskflow::Model::User.create!(
    name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.unique.email,
    password_digest: BCrypt::Password.create("password123"),
    cpf: cpf,
    phone_number: Faker::PhoneNumber.cell_phone_in_e164
  )
end

puts "#{Taskflow::Model::User.count} usuários criados com sucesso!"
