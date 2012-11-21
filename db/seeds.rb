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
#url

soledad.articles.create!(headline: 'Último cómputo: Oposición obtiene 43,10% y el oficialismo un 37,47% en alcaldes', 
	deck:'Subsecretario Rodrigo Ubilla entregó reporte que considera el 95,94 por ciento de las mesas escrutadas.', 
	story:'SANTIAGO.- Casi seis puntos porcentuales de diferencia en alcaldes arrojó el último cómputo oficial entregado este lunes por el subsecretario del Interior, Rodrigo Ubilla.
De acuerdo al reporte, que considera el 95,94 por ciento de las mesas escrutadas, la Coalición por el Cambio obtuvo un total de 1.1971.651 votos, equivalentes al 37,47%.
Mientras que los pactos opositores "Por un Chile justo" y "Concertación democrática" alcanzaron un 13,70% y 29,40%, respectivamente, que sumados llegan al 43,10 por ciento de las preferencias (2.267.638 sufragios).',
is_published: true)

900.times do
	soledad.articles.create(headline: Faker::Lorem.sentence(word_count = 4), 
		deck: Faker::Lorem.paragraph(sentence_count = 2), 
		story: Faker::Lorem.paragraph(sentence_count = 4))
endx


