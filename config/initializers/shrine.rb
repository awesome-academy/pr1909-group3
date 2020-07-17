# frozen_string_literal: true

require 'shrine'
require 'shrine/storage/s3'

s3_options = {
  # Required
  region: ENV['aws_region'],
  bucket: ENV['aws_bucket'],
  access_key_id: ENV['aws_access_key_id'],
  secret_access_key: ENV['aws_secret_access_key'],
  # endpoint: ENV['endpoint']
}

# The S3 storage plugin handles uploads to Amazon S3 service, using the aws-sdk gem.
Shrine.storages = {
  cache: Shrine::Storage::S3.new(prefix: 'cache', **s3_options), # temporary
  store: Shrine::Storage::S3.new(**s3_options),                  # permanent
}

# Plugins

# Provides ActiveRecord integration, adding callbacks and validations.
Shrine.plugin :activerecord
# Automatically logs processing, storing and deleting, with a configurable format.
Shrine.plugin :logging, logger: Rails.logger

Shrine.plugin :backgrounding

# Setup background jobs (sidekiq workers) for async uploads.
Shrine::Attacher.promote { |data| ShrineBackgrounding::PromoteJob.perform_async(data) }
Shrine::Attacher.delete { |data| ShrineBackgrounding::DeleteJob.perform_async(data) }
