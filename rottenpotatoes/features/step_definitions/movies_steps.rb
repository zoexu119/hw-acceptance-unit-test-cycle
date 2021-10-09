
Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create movie
  end
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  expect(page.body.index(e1) < page.body.index(e2))
end

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(', ').each do |rating|
    step %{I #{uncheck.nil? ? '' : 'un'}check "ratings_#{rating}"}
  end
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  Movie.all.each do |movie|
    step %{I should see "#{movie.title}"}
  end
end

Then /(.*) seed movies should exist/ do | n_seeds |
  Movie.count.should be n_seeds.to_i
end

When /^I press "(.*)" button/ do |button|
  click_button button
end

When /go to the edit page for "(.*)"/ do |movie_title|
  visit edit_movie_path(Movie.find_by(title: movie_title))
end

Given /on the details page for "(.*)"/ do |movie_title|
  visit movie_path(Movie.find_by(title: movie_title))
end

Then /the (\S+) of "(.*)" should be "(.*)"/ do |field_name, movie_name, field_value|
  # Make sure that all the movies in the app are visible in the table
  Movie.find_by(title: movie_name)[field_name].should match(field_value)
end

Given /am on the RottenPotatoes home page/ do
  visit movies_path
end

Given /am on the home page/ do
  visit movies_path
end

Then /should be on the home page/ do
  # Make sure that all the movies in the app are visible in the table
  visit movies_path
end

Then /should be on the Similar Movies page for "(.*)"/ do |movie_title|
  # Make sure that all the movies in the app are visible in the table
  visit directors_path({:director => Movie.find_by(title: movie_title).director})
end

Then /should see "([^"]*)" has no "([^"]*)" info/ do |movie_title, column_name|
  # Make sure that all the movies in the app are visible in the table
  Movie.find_by(title: movie_title)[column_name].should match('')
end