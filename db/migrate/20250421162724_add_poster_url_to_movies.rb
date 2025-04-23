class AddPosterUrlToMovies < ActiveRecord::Migration[7.2]
  def change
    add_column :movies, :poster_url, :string
  end
end
