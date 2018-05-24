module OrganisationHelper
  def child_organisations_count(organisation)
    organisation["works_with"].values.flatten.count
  end

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

  def ordered_featured_policies(organisation)
    featured_policies = []
    if organisation.content_item.content_item_data["links"]["ordered_featured_policies"].presence
      organisation.content_item.content_item_data["links"]["ordered_featured_policies"].each do |policy|
        featured_policies << policy
      end
    else
      featured_policies
    end
    featured_policies
  end
end
