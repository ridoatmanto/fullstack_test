require_relative 'recipe'

describe Recipe do
  before do
    Recipe.clear

    Recipe.describe do
      recipe 'Pancake' do
        ['Store-bought pancake mix,Water', 'Mix the ingredients,Cook them in a pan']
        # ingredient 'Store-bought pancake mix'
        # ingredient 'Water'

        # method 'method_steps' do
        #   step 'Mix the ingredients'
        #   step 'Cook them in a pan'
        # end
      end

      recipe 'Miso Soup' do
        ['Tofu,White miso paste', 'Mix miso paste into boiling water,Add tofu and serve']
        # ingredient 'Tofu'
        # ingredient 'White miso paste'

        # method do
        #   step 'Mix miso paste into boiling water'
        #   step 'Add tofu and serve'
        # end
      end
    end
  end

  it 'records the ingredients and method of each recipe' do
    pancake_recipe = Recipe.for('Pancake')

    expect(pancake_recipe.name).to eq 'Pancake'
    expect(pancake_recipe.ingredients).to eq ['Store-bought pancake mix', 'Water']
    expect(pancake_recipe.method_steps).to eq ['Mix the ingredients', 'Cook them in a pan']

    soup_recipe = Recipe.for('Miso Soup')

    expect(soup_recipe.name).to eq 'Miso Soup'
    expect(soup_recipe.ingredients).to eq ['Tofu', 'White miso paste']
    expect(soup_recipe.method_steps).to eq ['Mix miso paste into boiling water', 'Add tofu and serve']
  end
end
