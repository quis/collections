module OrganisationHelper
  def child_organisation_count(organisation)
    child_orgs = organisation.content_item.content_item_data["links"]["ordered_child_organisations"]
    child_orgs.present? ? child_orgs.count : 0
  end

  def show_organisation(organisation)
    if organisation.content_item.content_item_data["details"]["organisation_govuk_status"]["status"] == "live"
      render partial: 'show_organisation',
             locals: { organisation: @organisation }
    else
      render partial: 'separate_website',
             locals: { organisation: @organisation }
    end
  end

  def organisation_closed_govuk_status_description(organisation)
    if organisation_govuk_status(organisation) == "changed_name"
      "#{organisation_title(organisation)} has closed"
    elsif organisation_govuk_status(organisation) == "replaced" || organisation_govuk_status(organisation) == "split"
      "#{organisation_title(organisation)} has closed"
    elsif organisation_govuk_status(organisation) == "merged"
      "#{organisation_title(organisation)} has closed"
    elsif organisation_govuk_status(organisation) == "left_gov"
      "#{organisation_title(organisation)} has closed"
    elsif organisation_govuk_status(organisation) == "devolved"
      "#{organisation_title(organisation)} has closed"
    elsif organisation_govuk_status(organisation) == "no_longer_exists"
      "#{organisation_title(organisation)} has closed"
    elsif organisation_govuk_status(organisation) == "superseded_by_devolved_administration"
      "#{organisation_title(organisation)} has closed"
    end
  end

  def feed_entry_id(organisation_web_url, organisation)
    "#{organisation_web_url}##{public_updated_at(organisation)}"
  end

  def public_updated_at(organisation)
    Time.zone.parse(organisation.content_item.content_item_data["public_updated_at"])
  end

private
  def organisation_govuk_status(organisation)
    organisation.content_item.content_item_data["details"]["organisation_govuk_status"]["status"]
  end

  def organisation_title(organisation)
    organisation.content_item.content_item_data["title"]
  end
end
