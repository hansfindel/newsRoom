# encoding: UTF-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


roles = User::ROLES #arreglo con los posibles roles de los usuarios

soledad = User.last

#reuter = NewsAgency.create!(name:"IPS News", feed_url:"http://feeds.mashable.com/mashable")

soledad.articles.create!(headline: 'Último cómputo: Oposición obtiene 43,10% y el oficialismo un 37,47% en alcaldes', 
	deck:'Subsecretario Rodrigo Ubilla entregó reporte que considera el 95,94 por ciento de las mesas escrutadas.', 
	story:'SANTIAGO.- Casi seis puntos porcentuales de diferencia en alcaldes arrojó el último cómputo oficial entregado este lunes por el subsecretario del Interior, Rodrigo Ubilla.
De acuerdo al reporte, que considera el 95,94 por ciento de las mesas escrutadas, la Coalición por el Cambio obtuvo un total de 1.1971.651 votos, equivalentes al 37,47%.
Mientras que los pactos opositores "Por un Chile justo" y "Concertación democrática" alcanzaron un 13,70% y 29,40%, respectivamente, que sumados llegan al 43,10 por ciento de las preferencias (2.267.638 sufragios).',
is_published: true)

Article.create(headline:' Candidaturas de famosos: Cecilia Serrano y Carla Ochoa entre los ganadores', 
	deck:'Magaly Acevedo, Carla Ochoa y Lissette Sierra fueron algunas de las postulantes que ganaron con el respaldo de la UDI y RN, mientras que la oposición se destacó con Cecilia Serrano, Claudio Arredondo y Patricio Achurra.', 
	story:'SANTIAGO.-La derecha se impuso con ocho concejales pertenecientes al mundo del espectáculo en las elecciones de este domingo, en tanto que la Concertación alcanzó cinco triunfos.
No obstante, la periodista Cecilia Serrano  fue la única candidata independiente, apoyada por la Concertación Democrática, que logró un puesto en el consejo de la comuna de Las Condes.
Asimismo, se consolidó como mayoría nacional tras ser escogida con 10.146 votos, es decir, el 14,58 por ciento.',
is_published: true)

Article.create(headline:'Líderes de España e Italia presiden cumbre bilateral centrada en crisis económica', 
	deck:'Mariano Rajoy y Mario Monti tendrán ocasión de analizar la posibilidad de solicitar ayuda financiera a la UE y ratificarán su alianza en defensa de una unión bancaria europea. ', 
	story:'MADRID.- El Jefe del Ejecutivo español, Mariano Rajoy, recibió hoy con honores militares en el Palacio de la Moncloa al Primer Ministro italiano, Mario Monti, antes del comienzo de la XVII cumbre bilateral, centrada en la crisis económica que atraviesan ambos países.
En el cuarto encuentro bilateral que celebrarán este año, los dos mandatarios analizarán la situación económica y financiera y la necesidad de recuperar la confianza de los mercados para rebajar los altos intereses que se ven obligados a pagar ambos países.',
is_published: false)



