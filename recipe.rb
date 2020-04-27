class Recipe
  attr_reader :name, :description, :difficulty, :prep_time, :done

  def initialize(name, description, options = {})
    @name = name
    @description = description
    @difficulty = options[:difficulty]
    @prep_time = options[:prep_time]
    @done = false
  end

  def done
    @done = true
  end
end
