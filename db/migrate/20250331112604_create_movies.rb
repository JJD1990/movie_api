class CreateMovies < ActiveRecord::Migration[7.2]
  def change
    create_table :actors do |t|
      t.string :name

      t.timestamps
    end

    create_table :movies do |t|
      t.string :title
      t.date :year
      t.decimal :rating
      t.integer :runtime
      t.string :director

      t.timestamps
    end

    create_table :actors_movies do |t|
      t.references :movie, foreign_key: true
      t.references :actor, foreign_key: true
    end
  end
end
