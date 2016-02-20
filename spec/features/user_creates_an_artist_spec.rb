require 'rails_helper'

RSpec.feature "User submits a new artist" do
  scenario "they see the page for the individual artist" do
    artist_name       = "Bob Marley"
    artist_image_path = "http://cps-static.rovicorp.com/3/JPG_400/MI0003/146/MI0003146038.jpg"

    visit artists_path
    click_on 'New artist'
    fill_in "artist_name", with: artist_name
    fill_in "artist_image_path", with: artist_image_path
    click_on "Create Artist"

    expect(page).to have_content artist_name
    expect(page).to have_css("img[src=\"#{artist_image_path}\"]")
  end

  context "the submitted data is invalid" do
   scenario "they see an error message" do
     artist_image_path = "http://cps-static.rovicorp.com/3/JPG_400/MI0003/146/MI0003146038.jpg"

     visit artists_path
     click_on "New artist"
     fill_in "artist_image_path", with: artist_image_path
     click_on "Create Artist"
     expect(page).to have_content "Name can't be blank"
   end
 end

  scenario "users views all artists" do
    artist_name1       = "Bob Marley"
    artist_image_path1 = "http://cps-static.rovicorp.com/3/JPG_400/MI0003/146/MI0003146038.jpg"
    artist_name2       = "The Beatles"
    artist_image_path2 = "http://d817ypd61vbww.cloudfront.net/sites/default/files/styles/media_responsive_widest/public/tile/image/YellowSub.jpg?itok=EMK_FRld"

    visit new_artist_path
    fill_in "artist_name", with: artist_name1
    fill_in "artist_image_path", with: artist_image_path1
    click_on "Create Artist"

    visit new_artist_path
    fill_in "artist_name", with: artist_name2
    fill_in "artist_image_path", with: artist_image_path2
    click_on "Create Artist"
    visit artists_path
    expect(page).to have_content artist_name1
    expect(page).to have_content artist_name2
    expect(page).to have_css("img[src=\"#{artist_image_path1}\"]")
    expect(page).to have_css("img[src=\"#{artist_image_path2}\"]")

    click_on "Bob Marley"
    expect(page).to have_content artist_name1

  end

  scenario "edit an artist" do
    artist_name1       = "Bob Marley"
    artist_image_path1 = "http://cps-static.rovicorp.com/3/JPG_400/MI0003/146/MI0003146038.jpg"

    visit new_artist_path
    fill_in "artist_name", with: artist_name1
    fill_in "artist_image_path", with: artist_image_path1
    click_on "Create Artist"

    click_on "Edit Artist"

    expect(page).to have_content artist_name1

    fill_in "artist_name", with: "New Name"
    click_on "Update Artist"

    expect(page).to have_content "New Name"

    visit artists_path
  end

  scenario "delete an artist" do
    artist_name1       = "Bob Marley"
    artist_image_path1 = "http://cps-static.rovicorp.com/3/JPG_400/MI0003/146/MI0003146038.jpg"

    visit new_artist_path
    fill_in "artist_name", with: artist_name1
    fill_in "artist_image_path", with: artist_image_path1
    click_on "Create Artist"

    click_on "Delete Artist"

    expect(page).to have_content "All Artists" #how do we assert it doesn't have a name
    expect(page).to_not have_content("Bob Marley")
  end

end
