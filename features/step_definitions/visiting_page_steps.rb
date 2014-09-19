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

Given(/^there is a widget named "(.*?)"$/) do |arg1|
  @widget = Widget.create name: arg1
end

Given(/^I am on the "(.*?)" show page$/) do |arg1|
  visit widget_path(Widget.find_by(name: arg1))
end

When(/^I click the "(.*?)" button$/) do |arg1|
  click_button arg1
end

Then(/^I should not have one widget named "(.*?)"$/) do |arg1|
  expect(Widget.where(name: arg1).count).to eq(0)
end

When(/^I am on the "(.*?)" edit page$/) do |arg1|
  visit edit_widget_path(Widget.find_by(name: arg1))
end
