When(/^I visit the "(.*?)"$/) do |arg1|
  visit send(arg1.to_sym)
end

Then(/^the page should have "(.*?)"$/) do |arg1|
  expect(page.body).to include(arg1)
end
