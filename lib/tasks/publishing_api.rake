namespace :publishing_api do
  desc "Publish modeling services task list page"
  task publish_task_list_page: :environment do
    logger = Logger.new(STDOUT)

    publisher = SpecialRoutePublisher.new(
      logger: logger,
      publishing_api: Services.publishing_api
    )

    SpecialRoutePublisher.routes.each do |route_type, routes_for_type|
      routes_for_type.each do |route|
        publisher.publish(route_type, route)
      end
    end
  end
end
