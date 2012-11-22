# encoding: UTF-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'

roles = User::ROLES #arreglo con los posibles roles de los usuarios

soledad = User.last

#reuter = NewsAgency.create!(name:"IPS News", feed_url:"http://feeds.mashable.com/mashable")

reuter = NewsAgency.create!(name:"IPS News", feed_url:"www.ipsnews.net", is_api: false)
#datos de la API de NYTimes
#body -> story
#date -> published on
#title -> headline
#byline -> deck
#results -> results
#url

feedzilla = NewsAgency.create!(name: "Feedzilla", feed_url:"http://api.feedzilla.com/v1/categories/21/articles.json", is_api: true, api_values:{:story, '',:results => 'articles', :headline => 'title', :deck => 'summary', :published_on => 'publish_date', :url => 'url}' )


#900.times do
#	soledad.articles.create(headline: Faker::Lorem.sentence(word_count = 4), 
#		deck: Faker::Lorem.paragraph(sentence_count = 2), 
#		story: Faker::Lorem.paragraph(sentence_count = 4), is_published: true)
#end


