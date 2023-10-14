unless Rails.env.production?
  Rack::MiniProfiler.config.position = 'bottom-left'
end