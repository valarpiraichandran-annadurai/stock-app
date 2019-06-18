SENDGRID_CONFIG = YAML.load_file("#{Rails.root.to_s}/config/application.yml")[Rails.env]

SENDGRID_CONFIG['SENDGRID_API_KEY'] = ENV['SENDGRID_API_KEY'] if ENV['SENDGRID_API_KEY']