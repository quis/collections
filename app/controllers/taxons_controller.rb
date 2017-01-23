class TaxonsController < ApplicationController
  before_action :redirect_to_www, unless: :new_navigaton_enabled?

  def show
    render :show, locals: {
      taxon: taxon,
      navigation_helpers: navigation_helpers
    }
  end

private

  def new_navigaton_enabled?
    ENV['ENABLE_NEW_NAVIGATION'] == 'yes'
  end

  def redirect_to_www
    redirect_to Plek.find('www')
  end

  def taxon
    @taxon ||= Taxon.find(request.path)
  end

  def navigation_helpers
    @navigation_helpers ||= begin
      content_item = taxon.content_item.content_item_data
      GovukNavigationHelpers::NavigationHelper.new(content_item)
    end
  end
end
