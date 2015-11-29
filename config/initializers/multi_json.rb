MultiJson.use :yajl
unless Rails.env.production?
  MultiJson.dump_options = { pretty: true }
end

