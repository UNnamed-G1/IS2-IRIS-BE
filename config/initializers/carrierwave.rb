CarrierWave.configure do |config|
  config.directory_permissions = 0777
  config.ignore_integrity_errors = false
  config.ignore_processing_errors = false
  config.ignore_download_errors = false
  end