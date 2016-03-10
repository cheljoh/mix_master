require 'rails_helper'

RSpec.feature "User creates a playlist" do
  scenario "they see the page for the individual playlist" do
    song_one, song_two, song_three = create_list(:song, 3)

    playlist_name = "My Jams"

    visit playlists_path
    click_on "New playlist"
    fill_in "playlist_name", with: playlist_name
    check("song-#{song_one.id}")
    check("song-#{song_three.id}")
    click_on "Create Playlist"
    expect(page).to have_content playlist_name

    within("li:first") do
      expect(page).to have_link song_one.title, href: song_path(song_one)
    end

    within("li:last") do
      expect(page).to have_link song_three.title, href: song_path(song_three)
    end
  end

  scenario "they see the names of each playlist" do
    song_one, song_two, song_three = create_list(:song, 3)

    playlist_name = "My Jams"

    visit playlists_path
    click_on "New playlist"
    fill_in "playlist_name", with: playlist_name
    check("song-#{song_one.id}")
    check("song-#{song_three.id}")
    click_on "Create Playlist"


    visit playlists_path

    click_on "My Jams"

    expect(page).to have_content "My Jams"
  end

  scenario "user edits a playlist" do
    song_one, song_two, song_three = create_list(:song, 3)

    playlist_name = "My Jams"

    visit playlists_path
    click_on "New playlist"
    fill_in "playlist_name", with: playlist_name
    check("song-#{song_one.id}")
    check("song-#{song_three.id}")
    click_on "Create Playlist"


    visit playlists_path
    click_on "My Jams"
    click_on "Edit Playlist"
    fill_in "playlist_name", with: "It changed"
    check("song-#{song_two.id}")
    click_on "Update Playlist"

    expect(page).to have_content "It changed"
    expect(page).to have_content "B Title"


  end

  scenario "they see the updated data for the individual playlist" do
    playlist             = create(:playlist_with_songs)
    first, second, third = playlist.songs
    new_song             = create(:song, title: "New Song")

    visit playlist_path(playlist)
    click_on "Edit"
    uncheck("song-#{first.id}")
    check("song-#{new_song.id}")
    click_on "Update Playlist"

    expect(page).to have_content playlist.name
    expect(page).to_not have_content first.title
    expect(page).to have_content new_song.title
  end
end
