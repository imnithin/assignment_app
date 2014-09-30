json.array!(@plans) do |plan|
  json.extract! plan, :id, :title, :name, :detail
  json.url plan_url(plan, format: :json)
end
