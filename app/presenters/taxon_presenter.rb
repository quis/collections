class TaxonPresenter
  attr_reader :taxon
  delegate(
    :content_id,
    :title,
    :description,
    :base_path,
    :child_taxons,
    :live_taxon?,
    :section_content,
    :organisations,
    to: :taxon
  )

  def initialize(taxon)
    @taxon = taxon
  end

  def sections
    SupergroupSections.supergroup_sections(taxon.content_id, taxon.base_path)
  end

  def organisations_section
    @taxon_organisations ||= TaxonOrganisationsPresenter.new(organisations)
  end

  def show_subtopic_grid?
    child_taxons.count.positive?
  end

  def options_for_child_taxon(index:)
    {
      module: 'track-click',
      track_category: 'navGridContentClicked',
      track_action: (index + 1).to_s,
      track_label: child_taxons[index].base_path,
      track_options: {},
    }
  end
end
