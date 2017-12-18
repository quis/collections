class TasklistController < ApplicationController
  def show
    content_item = ContentItem.find!("/learn-to-drive-a-car")

    render :show, locals: {
      content_item: content_item,
      tasklist: GovukNavigationHelpers::TasklistContent.new(file_name: 'learn-to-drive-a-car')
    }
  end

  def show_end_a_civil_partnership
    content_item = ContentItem.find!("/end-a-civil-partnership")

    render :show, locals: {
      content_item: content_item,
      tasklist: GovukNavigationHelpers::TasklistContent.new(file_name: 'end-a-civil-partnership')
    }
  end

  def show_get_a_divorce
    content_item = ContentItem.find!("/get-a-divorce")

    render :show, locals: {
      content_item: content_item,
      tasklist: GovukNavigationHelpers::TasklistContent.new(file_name: 'get-a-divorce')
    }
  end
end
