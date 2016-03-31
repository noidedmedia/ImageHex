MultiJson.use :yajl
MultiJson.dump_options = { pretty: true } unless Rails.env.production?
