Given(/^there is curated content for a subtopic$/) do
  stub_topic_lookups
end

Then(/^I see a curated list of content$/) do
  assert page.has_selector?("h1", text: "Oil rigs")
  assert page.has_selector?("h1", text: "Piping")
end
