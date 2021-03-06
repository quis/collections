class OrganisationsController < ApplicationController
  skip_before_action :set_expiry
  before_action -> { set_expiry(5.minutes) }
  before_action :set_locale, only: :show

  def index
    @organisations = ContentStoreOrganisations.find!("/government/organisations")
    @presented_organisations = presented_organisations
    setup_content_item_and_navigation_helpers(@organisations)
  end

  def show
    @organisation = Organisation.find!("/government/organisations/#{params[:organisation_name]}#{locale}")
    setup_content_item_and_navigation_helpers(@organisation)

    @show = Organisations::ShowPresenter.new(@organisation)
    @header = Organisations::HeaderPresenter.new(@organisation)
    @documents = Organisations::DocumentsPresenter.new(@organisation)
    @what_we_do = Organisations::WhatWeDoPresenter.new(@organisation)
    @people = Organisations::PeoplePresenter.new(@organisation)
    @not_live = Organisations::NotLivePresenter.new(@organisation)
    @contacts = Organisations::ContactsPresenter.new(@organisation)

    respond_to do |f|
      f.html do
        render :show, locals: {
            organisation: @organisation
        }
      end
      f.json do
        render json: {
            breadcrumbs: breadcrumb_content,
            html: show_organisation_partial(@organisation)
        }
      end
    end
  end

private

  def show_organisation_partial(organisation)
    render_partial('organisation/_show_organisation',
                   organisation: organisation)
  end

  def presented_organisations
    @presented_organisations ||= Organisations::IndexPresenter.new(@organisations)
  end

  def locale
    ".#{params[:locale]}" if params[:locale]
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
