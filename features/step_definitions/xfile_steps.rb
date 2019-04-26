Given(/^the following files exist:$/) do |xfiles_table|
  xfiles_table.hashes.each do |xfile|
    Xfile.create xfile
  end
end

When /^(?:|I )upload a json file$/ do
  attach_file('content[]', File.join(RAILS_ROOT, 'features', 'upload-files', 'sample1.json'))
  click_button "import"
end

When /^(?:|I )upload a xml file$/ do
  attach_file('content[]', File.join(RAILS_ROOT, 'features', 'upload-files', 'sample2.xml'))
  click_button "import"
end

When /^(?:|I )upload an invalid file$/ do
  attach_file('content[]', File.join(RAILS_ROOT, 'features', 'upload-files', 'sample3.txt'))
  click_button "import"
end

Given /^(?:|I )visit the (.+)$/ do |page_name|
  visit path_to(page_name)
end

And /^(?:|I )am on (.+)$/ do |page_name|
  visit path_to(page_name)
end

Then(/^I should see "([^"]*)"$/) do |text|
  if page.respond_to? :should
    page.should have_content(text)
  else
    assert page.has_content?(text)
  end
end

When(/^I click "([^"]*)" for "([^"]*)"$/) do |arg1, arg2|
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I should see "([^"]*)"a"([^"]*)"a"([^"]*)"$/) do |arg1, arg2, arg3|
  pending # Write code here that turns the phrase above into concrete actions
end

And(/^I should be sent to the (.+)$/) do |page_name|
  visit path_to(page_name)
end

When(/^I don't upload a file$/) do
  click_button "import"
end
When /I check the following file: (.*)/ do |field|
  page.all('[id^="xfile_"]').each do |el|
    if el.value != nil
      within find("#xfile_#{el.value}") do
        check("xfile_id_")
      end
    end
  end
end

When /I click Get Shared Properties/ do
  find('#xfile_form').click
end

Then(/^I should see the file upload page again$/) do
  visit path_to("file upload page")
end
