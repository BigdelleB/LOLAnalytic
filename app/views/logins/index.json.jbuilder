json.array!(@logins) do |login|
  json.extract! login, :id, :Username, :Region
  json.url login_url(login, format: :json)
end
