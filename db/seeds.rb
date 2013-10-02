# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

catalogue = Category.create title: "Catalogue"
books = Category.create title: "Books", parent: catalogue
videos = Category.create title: "Videos", parent: catalogue
games = Category.create title: "Games", parent: catalogue
fantasy = Category.create title: "Fantasy", parent: books
sci_fi = Category.create title: "Sci-fi", parent: books
fps = Category.create title: "FPS", parent: games