unless Rails.env.prodution?
  Rack::MiniProfiler.config.position = 'bottom-left'
end