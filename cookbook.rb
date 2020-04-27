require "csv"

class Cookbook
  def initialize(csv_file)
    @csv_file = csv_file
    @recipes = []
    load_csv
  end

  def add_recipe(recipe)
    @recipes.push(recipe)
    save_csv
  end

  def all
    @recipes
  end

  def remove_recipe(idx)
    @recipes.delete_at(idx)
    save_csv
  end

  def find(idx)
    @recipes[idx]
  end

  def mark_done(idx)
    recipe = @recipes[idx]
    recipe.done
    save_csv
  end

  private

  def load_csv
    CSV.foreach(@csv_file) do |row|
      @recipes << Recipe.new(row[0], row[1], difficulty: row[2], prep_time: row[3])
    end
  end

  def save_csv
    CSV.open(@csv_file, "wb") do |csv|
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.difficulty, recipe.prep_time, recipe.done]
      end
    end
  end
end
