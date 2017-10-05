require 'statsd'
require 'gds_api/email_alert_api'
require 'gds_api/content_store'
require 'gds_api/publishing_api_v2'
require 'gds_api/rummager'

module Services
  def self.email_alert_api
    @email_alert_api ||= GdsApi::EmailAlertApi.new(Plek.new.find('email-alert-api'))
  end

  def self.content_store
    @content_store ||= GdsApi::ContentStore.new(Plek.new.find('content-store'))
  end

  def self.publishing_api
    @publishing_api ||= GdsApi::PublishingApiV2.new(
      Plek.new.find('publishing-api'),
      bearer_token: ENV['PUBLISHING_API_BEARER_TOKEN'] || 'example')
  end

  def self.rummager
    @rummager ||= GdsApi::Rummager.new(Plek.new.find("search"))
  end

  def self.statsd
    @statsd ||= begin
      statsd_client = Statsd.new("localhost")
      statsd_client.namespace = ENV['GOVUK_STATSD_PREFIX'].to_s
      statsd_client
    end
  end
end
