json.array!(@results) do |result|
    json.id result.id
    json.value result.title
end