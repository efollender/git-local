class Recipe
	attr_reader :name, :servings
	attr_accessor :ingredients
	def initialize(recipe)
		@name = recipe[:title]
		@servings = recipe[:servings]
		@ingredients = []
		recipe[:ingredients].each do |x|
			@ingredients.push(Ingredient.new(x))
		end
	end
	def add_ingredient(ingred)
		if (ingred.class == Ingredient)
			@ingredients.push(ingred)
		else
			puts "That's not an ingredient"
		end
	end
end

class Ingredient
	attr_reader :name, :units
	attr_accessor :amount
	def initialize(ingred)
		measurements = ["cup","tbs","cups","oz","lbs","tsp"]
		ing_arr = ingred.split(" ")
		if (ing_arr[0].to_i > 0)
			@amount = ing_arr.first.to_i
			if (measurements.include? ing_arr[1])
				@units = ing_arr[1]
				@name = ing_arr.last(ing_arr.size - 2).join(" ")
			else
				@name = ing_arr.last(ing_arr.size - 1).join(" ")
			end
		else
			@name = ingred
			@amount = ""
			@units = ""
		end
	end
	def amount=(new_amt)
		@amount = new_amt
	end
end
class RecipeParser
	@@neat_recipes = []
	@@cookbook = []
	def self.read_recipes(file)
		cookbook = File.read(file)
		recipes = cookbook.split("\n\n")
		recipes = recipes.map {|x| x.split("\n")}
		recipes.each do |recipe|
			ingredients = recipe.size - 2
			@@neat_recipes.push({title: recipe[0], servings: recipe[1].split(" ").last.to_i, ingredients: recipe.last(ingredients)})
			@@neat_recipes
		end
	end
	def self.recipes_to_cookbook
		@@neat_recipes.each do|x|
			@@cookbook << Recipe.new(x)
		end
		p @@cookbook
	end
	def self.print_cookbook
		@@cookbook.each do |x|
			puts "Recipe: #{x.name.capitalize}"
			puts "Serves: #{x.servings}"
			puts "Ingredients:"
			x.ingredients.each do |x|
				puts "  #{x.amount} #{x.units} #{x.name}"
			end
			puts "\n"
		end
	end
end
RecipeParser.read_recipes("./recipes.txt")
RecipeParser.recipes_to_cookbook
RecipeParser.print_cookbook
