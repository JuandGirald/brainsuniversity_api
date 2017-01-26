Apipie.configure do |config|
  config.app_name                = "BrainsuniversityApi"
  config.api_base_url            = ""
  config.doc_base_url            = "/apidoc"
  # where is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/api/v1/*.rb"
end
