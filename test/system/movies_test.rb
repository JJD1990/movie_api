require "application_system_test_case"

class MoviesTest < ApplicationSystemTestCase
  setup do
    @movie = movies(:one)
  end

  test "visiting the index" do
    visit movies_url
    assert_selector "h1", text: "Movies"
  end

  test "should create movie" do
    visit movies_url
    click_on "New movie"

    fill_in "Director", with: @movie.director
    fill_in "Rating", with: @movie.rating
    fill_in "Runtime", with: @movie.runtime
    fill_in "Title", with: @movie.title
    fill_in "Year", with: @movie.year
    click_on "Create Movie"

    assert_text "Movie was successfully created"
    click_on "Back"
  end

  test "should update Movie" do
    visit movie_url(@movie)
    click_on "Edit this movie", match: :first

    fill_in "Director", with: @movie.director
    fill_in "Rating", with: @movie.rating
    fill_in "Runtime", with: @movie.runtime
    fill_in "Title", with: @movie.title
    fill_in "Year", with: @movie.year
    click_on "Update Movie"

    assert_text "Movie was successfully updated"
    click_on "Back"
  end

  test "should destroy Movie" do
    visit movie_url(@movie)
    click_on "Destroy this movie", match: :first

    assert_text "Movie was successfully destroyed"
  end
end
