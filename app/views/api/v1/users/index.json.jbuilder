json.total_results @users.total_count
json.total_pages @users.total_pages
json.current_page @users.current_page
json.results @users do |user|
  json.call(user, :id, :name, :last_name, :masked_cpf, :email, :phone_number)
end
