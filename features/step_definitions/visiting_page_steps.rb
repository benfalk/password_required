When(/^I visit the "(.*?)"$/) do |arg1|
  visit send(arg1.to_sym)
end

Then(/^the page should have "(.*?)"$/) do |arg1|
  expect(page.body).to include(arg1)
end

When(/^put "(.*?)" in "(.*?)" field$/) do |arg1, arg2|
  fill_in arg2, with: arg1
end

When(/^click the "(.*?)" button$/) do |arg1|
  click_button arg1
end

Then(/^I should find a "(.*?)" field$/) do |arg1|
  should have_selector("input[name=\"#{arg1}\"]")
end

Then(/^I should have one widget named "(.*?)"$/) do |arg1|
  expect(Widget.where(name: arg1).count).to eq(1)
end

Then(/^put "(.*?)" in the "(.*?)" field$/) do |arg1, arg2|
  fill_in arg2, with: arg1
end
