require 'csv'

class Storage
  HEADERS = ['recipe', 'ingredient', 'step']
  FILE_STORAGE = 'recipe_storage.csv'

  def self.save(arr)
    CSV.open(FILE_STORAGE, 'a+', {col_sep: ';'}) do |csv|
      csv << HEADERS if csv.count.eql? 0
      csv << arr
    end
  end

  def self.row(recipe_name)
    f = File.open(FILE_STORAGE, 'r')
    f.each_line.with_index  do |line, index|
      next if index.zero?

      fields = line.split(';')
      fields.map { |row| row = row.to_s.chomp! }

      return fields if fields.first == recipe_name
    end
  end

  def self.empty_storage
    File.delete(FILE_STORAGE) if File.exist?(FILE_STORAGE)
  end
end

class Recipe
  def initialize(name, ingredients, steps)
    Storage.save([name, ingredients, steps])
  end

  def self.clear
    puts "Recipe Storage cleared!\n" if Storage.empty_storage
  end

  def self.for(recipe_name)
    result = Storage.row(recipe_name)
    ObjectFactory.new(result)
  end
end

class ObjectFactory
  attr_accessor :name, :ingredients, :method_steps
  
  def initialize(hash_param)
    [:name, :ingredients, :method_steps].each_with_index do |k,index|
      value = index.zero? ? hash_param[index] : hash_param[index].split(",")
      public_send("#{k}=",value)
    end
  end
end

def recipe(name, &block)
  params = yield
  Recipe.new(name, params[0], params[1])
end
