require 'gds_api/publishing_api/special_route_publisher'

class SpecialRoutePublisher
  attr_reader :publisher

  def initialize(publisher_options)
    @publisher = GdsApi::PublishingApi::SpecialRoutePublisher.new(publisher_options)
  end

  def publish(route_type, route)
    publisher.publish(
      route.merge(
        format: "special_route",
        publishing_app: "collections-publisher",
        rendering_app: "collections",
        type: route_type,
        public_updated_at: Time.zone.now.iso8601,
        update_type: "major",
      )
    )
  end

  def self.routes
    {
      exact: [
        {
          content_id: "f60afbe9-fcf6-484c-8778-4d66253c9075",
          base_path: "/TBD",
          title: "TBD",
          description: "TBD",
        }
      ]
    }
  end
end
