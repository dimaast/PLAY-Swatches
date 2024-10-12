# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Функция очистки и наполнения бд через сиды
def seed
  reset_db
  create_projects(10)
  create_swatches(2..8)
  create_fills(2..8)
end

# Функция очистки бд, которую встраиваем в seed
def reset_db
  Rake::Task['db:drop'].invoke
  Rake::Task['db:create'].invoke
  Rake::Task['db:migrate'].invoke
end

@hex_symbols = [ '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F' ]

def get_random_color
  color_hex = []
  6.times do
    color_hex << @hex_symbols.sample
  end

  color_hex.join('')
end

def create_projects(quantity)
  quantity.times do |i|
    project = Project.create(name: "Проект #{i + 1}")
    puts "Project with id #{project.id} created"
  end
end

def create_swatches(quantity)
  Project.all.each do |project|
    i = 1

    quantity.to_a.sample.times do
      swatch = project.swatches.create!(name: "Swatch #{i}")
      i += 1
      puts "Swatch #{swatch.name} with id #{swatch.id} for #{swatch.project.name} created"
    end
  end
end

def create_fills(quantity)
  Swatch.all.each do |swatch|
    i = 1
    quantity.to_a.sample.times do
      fill = swatch.fills.create!(name: "--color #{i}", color: get_random_color)
      i += 1
      puts "Fill #{fill.name} with color #{fill.color} with id #{fill.id} for #{fill.swatch.name} created"
    end
  end
end

seed
