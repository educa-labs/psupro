
=begin
#these are the basic data rows for the api to function
p1 = Country.create({title:"Chile"})

r1 = Region.create(title:"Tarapacá", country_id:p1.id)
r2 = Region.create(title:"Antofagasta", country_id:p1.id)
r3 = Region.create(title:"Atacama", country_id:p1.id)
r4 = Region.create(title:"Coquimbo", country_id:p1.id)
r5 = Region.create(title:"Valparaiso", country_id:p1.id)
r6 = Region.create(title:"O'higgins", country_id:p1.id)
r7 = Region.create(title:"Maule", country_id:p1.id)
r8 = Region.create(title:"Bio-Bio", country_id:p1.id)
r9 = Region.create(title:"La araucanía", country_id:p1.id)
r10 = Region.create(title:"Los Lagos", country_id:p1.id)
r11 = Region.create(title:"Aysén", country_id:p1.id)
r12 = Region.create(title:"Magallanes", country_id:p1.id)
r13 = Region.create(title:"Metropolitana", country_id:p1.id)
r14 = Region.create(title:"Los Ríos", country_id:p1.id)
r15 = Region.create(title:"Arica y Parinacota", country_id:p1.id)

c1 = City.create({title:"Santiago",region_id:r13.id})
Region.all.each do |r|
  City.create({title:"#{r.title} city", region_id:r.id})
end

l1 = Level.create({title:"High school"})
l2 = Level.create({title:"HS graduate"})
l3 = Level.create({title:"Superior"})
l4 = Level.create({title:"Superior Graduate"})

image = "andres@test.cl_picture"
ext = "jpeg"
us1 = User.create({first_name:"andres", last_name:"sofiagran",email:"andres@test.cl",password:"123456",
                   password_confirmation:"123456",rut:"30.686.957-4",birth_date:DateTime.new(1996,1,2),
                   city_id:c1.id,phone:"+56912345678",admin:false,preuniversity:true,notifications:true,
                   level_id:l3.id, nem:700, picture:image,extension:ext,tutorial:true,ranking:680})
encode_picture(Rails.public_path.to_s+ '/images/seed/Donald-Trump.jpg',image)

s1 = Subject.create({title:"Lenguaje"})
s2 = Subject.create({title:"Matemáticas"})
s3 = Subject.create({title:"Historia"})
s4 = Subject.create({title:"Ciencias Naturales"})

e1 = Essay.create({subject_id:s1.id, score:755, user_id:us1.id,title:"JORNADA 1 PDV"})
e2 = Essay.create({subject_id:s2.id, score:630, user_id:us1.id,title:"JORNADA 1 PDV"})
e3 = Essay.create({subject_id:s3.id, score:543, user_id:us1.id,title:"JORNADA 1 PDV"})
e4 = Essay.create({subject_id:s4.id, score:800, user_id:us1.id,title:"JORNADA 1 PDV"})

o1 = Objective.create({subject_id:s1.id, score:755, user_id:us1.id})
o2 = Objective.create({subject_id:s2.id, score:700, user_id:us1.id})
#o3 = Objective.create({subject_id:s3.id, score:750, user_id:us1.id})
o4 = Objective.create({subject_id:s4.id, score:800, user_id:us1.id})

it_1 = InstitutionType.create({title:"High school",level_id:l1.id})
it_2 = InstitutionType.create({title:"University",level_id:l3.id})

##This is to populate with invented data
if ENV['populator'] == 'mock'
  a1 = Area.create({title:"Ingenieria"})
  a2 = Area.create({title:"Ciencias sociales"})
  a3 = Area.create({title:"Humanidades"})
  ut1 = UniversityType.create({title:"Privada"})
  ut2 = UniversityType.create({title:"Pública"})

  i1 = Institution.create({title:"Pontificia universidad catolica",institution_type_id:it_2.id})
  i2 = Institution.create({title:"Universidad de Chile",institution_type_id:it_2.id})

  profile_uc = 'puc_profile'
  profile_uch = 'uch_profile'
  cover_uc = 'puc_cover'
  cover_uch = 'uch_cover'
  encode_picture(Rails.public_path.to_s +  '/images/seed/puc.jpg','universities/' + profile_uc)
  encode_picture(Rails.public_path.to_s +  '/images/seed/uch.jpg','universities/' + profile_uch)
  encode_picture(Rails.public_path.to_s +  '/images/seed/cc.jpg','universities/' + cover_uc)
  encode_picture(Rails.public_path.to_s +  '/images/seed/uchcc.jpg','universities/' + cover_uch)

  u1 = University.create({foundation:"6-6-6", website:"www.uc.cl", freeness:true,motto:"las 4 p", nick: "la ponti",
                          institution_id:i1.id,university_type_id:ut1.id,initials:"PUC",students:2,teachers:1,degrees:10,postgraduates:100,doctorates:2000,description:"La puc es una universidad terrible lais",profile_picture:profile_uc,profile_extension:'jpg',cover_picture:cover_uc,cover_extension:'jpg'})
  u2 = University.create({foundation:"6-6-6", website:"www.uch.cl", freeness:true,motto:"viva lx revolucion", nick: "la chile",
                        institution_id:i2.id,university_type_id:ut2.id,initials:"UCH",students:2,teachers:1,degrees:10,postgraduates:100,doctorates:2000,description:"La uch es una universidad terrible chana",profile_picture:profile_uch,profile_extension:'jpg',cover_picture:cover_uch,cover_extension:'jpg'})

  cam1 = Campu.create({title:"San joaquin",university_id:u1.id, lat:"00", long:"000",city_id:c1.id,address:"asdafdsfc"})

  carr1 = Carreer.create({title:"Ingenieria Civil",university_id:u1.id,campu_id:cam1.id,certification:7,semesters:12,price:5900000,
                          area_id:a1.id,schedule:"diurno",openings:700,employability:1,income:20000,admission:"PSU", last_cut:750,description:"Carrera llena de jiles pero vas a quedar entero forrado"})

  carr2 = Carreer.create({title:"Ingenieria Comercial",university_id:u1.id,campu_id:cam1.id,certification:7,semesters:12,price:3900000,
                          area_id:a2.id,schedule:"diurno",openings:700,employability:0.5,income:2000,admission:"PSU", last_cut:100,description:"Carrera llena de zorrones pero vas a quedar entero forrado"})

  carr3 = Carreer.create({title:"Injenieria Civil",university_id:u2.id,campu_id:cam1.id,certification:7,semesters:12,price:4900000,
                          area_id:a1.id,schedule:"diurno",openings:700,employability:1,income:20000,admission:"PSU", last_cut:720,description:"Carrera llena de jiles pero vas a quedar entero forrado"})

  carr4 = Carreer.create({title:"Derecho",university_id:u2.id,campu_id:cam1.id,certification:7,semesters:12,price:5900000,
                          area_id:a3.id,schedule:"diurno",openings:700,employability:0.8,income:20000,admission:"PSU", last_cut:600,description:"Carrera para aprender a manipular y exhortar hacia lx revolucixn"})

  w1 = Weighing.create({NEM:20, ranking:20, language:10,math:35,science:15,carreer_id:carr1.id})
  w2 = Weighing.create({NEM:20, ranking:20, language:20,math:25,science:15,history:15,carreer_id:carr2.id})
  w3 = Weighing.create({NEM:20, ranking:20, language:10,math:35,science:15,carreer_id:carr3.id})
  w4 = Weighing.create({NEM:20, ranking:20, language:35,math:10,history:15,carreer_id:carr4.id})


  us1.carreers << carr1


#This is to populate with last years data
elsif ENV['populator'] == 'csv'
  require 'csv'
  path = ENV['csv_path']
  #add career areas
  areas = CSV.read(path+'areas.csv',headers:true)
  areas_hash = {}
  areas.each do |row|
    a = Area.create({title:row['title']})
    areas_hash[row['id']] = a.id
  end

  #add university_types
  university_types = CSV.read(path+'university_types.csv',headers:true)
  university_types_hash = {}
  university_types.each do |row|
    ut = UniversityType.create({title:row['title']})
    university_types_hash[row['id']] = ut.id
  end

  #add universities

  boolean_hash ={'t':true,'f':false}
  universities_file = CSV.read(path + 'universities.csv',headers:true)
  universities_hash = {}
  universities_file.each do |row|
    it = Institution.create({title:row['title'],institution_type_id:it_2.id})
    puts row['title']
    if row['gratuity'].nil?
      u = University.create({motto:row['motto'],nick:row['slug'],website:row['web'],initials:row['initials'],freeness:false,institution_id:it.id,university_type_id:university_types_hash[row['university_type_id']]})
    else
      u = University.create({motto:row['motto'],nick:row['slug'],website:row['web'],initials:row['initials'],freeness:boolean_hash[row['gratuity'].to_sym],institution_id:it.id,university_type_id:university_types_hash[row['university_type_id']]})
    end

    universities_hash[row['id']] = u.id
  end

  #add campuses
  campus = CSV.read(path + 'campuses.csv',headers:true)
  campus_hash = {}
  campus.each do |row|
    puts row['title']
    c = Campu.create({address:row['address'],title:row['title'],lat:row['latitude'],long:row['longitude'],university_id:universities_hash[row['university_id']],city_id:Region.find_by(id:row['region_id']).cities.first.id})
    campus_hash[row['id']] = c.id
  end

  #add carreers

  degrees = CSV.read(path + 'degrees.csv',headers:true)
  u_degrees = CSV.read(path + 'university_degrees.csv', headers:true)
  u_degrees_hash = {}
  cuts = CSV.read(path + 'university_degree_years.csv',headers:true)
  d_campus = CSV.read(path + 'campuses_university_degrees.csv',headers:true)
  u_degrees.each do |row|
    camp = d_campus.find {|rw| rw['university_degree_id'] == row['id']}
    degree = degrees.find {|rw| rw['id'] == row['degree_id']}
    cut = cuts.find{|rw| rw['university_degree_id']==row['id']}
    if degree.nil?
      next
    end
    car = Carreer.create do |c|
      c.title = degree['title']
      c.area_id = areas_hash[degree['area_id']]
      c.university_id = universities_hash[row['university_id']]
      if campus
        c.campu_id = campus_hash[camp['campus_id']]
      end
      c.semesters = row['semesters']
      c.employability = row['employability'].to_f * 100
      c.income = row['salary']
      if cut
        c.last_cut = cut['last_enrolled']
      end
    end
    # if cut
    #   car = Carreer.create({title:degree['title'],university_id:row['university_id'],campu_id:campus_hash[camp['campus_id']],semesters:row['semesters'],employability:row['employability'],income:row['salary'],last_cut:cut['last_enrolled'],area_id:areas_hash[['area_id']]})
    # else
    #   car = Carreer.create({title:degree['title'],university_id:row['university_id'],campu_id:campus_hash[camp['campus_id']],semesters:row['semesters'],employability:row['employability'],income:row['salary'],area_id:areas_hash[['area_id']]})
    # end
    u_degrees_hash[row['id']] = car.id
  end

  #add weighings
  whs = CSV.read(path + 'weights.csv',headers:true)
  ponderators = CSV.read(path + 'weighings.csv',headers:true)
  whs.each do |row|
    w = Weighing.create do |wh|
      wh.NEM = Float(row['nem'])*100
      wh.ranking = Float(row['ranking'])*100
      wh.carreer_id = u_degrees_hash[row['university_degree_id']]
      ponds = ponderators.find_all {|rw| rw['weight_id']==row['id']}
      ponds.each do |p|
        if p['subject_id'] == '6'
          wh.history = Float(p['value'])*100
        elsif p['subject_id'] == '3'
          wh.science = Float(p['value'])*100
        elsif p['subject_id'] == '2'
          wh.language = Float(p['value'])*100
        else
          wh.math = Float(p['value'])*100
        end
      end
    end
  end

elsif ENV['populator'] == 'venezolanas'
  require 'csv'
	def read_tsv file_name
		return CSV.read(
		  Rails.root.join('lib', 'seeds', file_name), { headers: true,
		                                                col_sep: "\t", })
	end
  path = ENV['csv_path']
  #add career areas
  areas = read_tsv('areas.tsv')
  areas_hash = {}
  areas.each do |row|
    a = Area.create({title:row['title']})
    areas_hash[row['title']] = a.id
  end

  #add university_types
  university_types = read_tsv('university_types.tsv')
  university_types_hash = {}
  university_types.each do |row|
    ut = UniversityType.create({title:row['title']})
    university_types_hash[row['title']] = ut.id
  end
  university_types_hash.stringify_keys

  #add universities
  boolean_hash ={'Si':true,'No':false}
  universities_file = read_tsv('universidades.tsv')
  universities_hash = {}
  universities_file.each do |row|
    it = Institution.create({title:row['Nombre'],institution_type_id:university_types_hash[row['Tipo']]})
    puts row['Nombre']
    u = University.new do |u|
      u.motto = row['Lema']
      u.website = row['Sitio web']
      u.initials = row['Sigla']
      u.freeness = boolean_hash[row['Gratuidad'].to_sym]
      u.institution_id = it.id
      u.university_type_id = university_types_hash[row['Tipo']]
      dates = row['Fundación'].split('/')
      u.foundation = Date.new(dates[2].to_i,dates[1].to_i,dates[0].to_i)
      u.students = row['Nro de Alumnos']
      u.teachers = row['Nro de profesores']
      u.degrees = row['Nro de grados']
      u.postgraduates = row['Nro de postgrados']
      u.doctorates = row['Nro de doctorados']
      u.description = row['Descripción']
    end
    u.save
    universities_hash[row['id']] = u.id
  end

  #add Cities
  city_hash = {}
  campus = read_tsv('campuses.tsv')
  campus.each do |row|
    unless City.where(title:row['Ciudad']).limit(1)
      c = City.new do |c|
        c.title = row['Ciudad']
        c.region_id = row['id_region']
      end
      c.save
      city_hash[c.title] = c.id
    end
  end
  city_hash.stringify_keys

  #add campuses
  campus = read_tsv('campuses.tsv')
  campus_hash = {}
  campus.each do |row|
    puts row['Nombre']
    c = Campu.new do |c|
      c.address = row['Dirección']
      c.title = row['title']
      c.lat = row['latitude']
      c.long = row['longitude']
      c.university_id= universities_hash[row['university_id']]
      c.city_id = city_hash[row['Ciudad']]
    end
    c.save
    campus_hash[row['id']] = c.id
  end

  #add carreers
  certification_hash = {"No" => false, "Si" => true}
  degrees = read_tsv('carreras.tsv')
  degrees_hash = {}
  degrees.each do |row|
    car = Carreer.new do |car|
      car.title = row['Nombre']
      car.university_id = universities_hash[row['ID Universidad']]
      car.campus_id = campus_hash[row['ID Campus']]
      car.certification = certification_hash[row['Acreditación']]
      car.openings = row['Vacantes']
      car.semesters = row['Cant. Semestres']
      car.price = row['arancel']
      car.area = areas_hash[row['Área']]
      car.schedule = row['Horario']
      car.employability = row['Empleabilidad']
      car.income = row['Ingreso']
      car.admission = row['Admisión']
      #TODO importante !!! se debe agregar soporte para los dos cortes
      car.last_cut = row['Corte 2017']
      car.description = row['Descripción']
    end
    w = Weighing.new do |w|
      w.language = row['Lenguaje']
      w.math = row['Matemáticas']
      w.history = row['Historia (Cs. Sociales)']
      w.science = row['Ciencias']
      w.NEM = row['NEM']
      w.ranking = row['ranking']
    end
    car.save
    w.carreer_id = car.id
    w.save
  end



end







cq = CarreerQuestion.create({question:"Es cierto que en ing son todos zorrones?",carreer_id:Carreer.first.id,user_id:us1.id,details:"aggg",likes:0,dislikes:0,date:DateTime.new(2016,1,1,1,1)})

uq = UniversityQuestion.create({question:"Es cierto que en la puc son todos zorrones?",university_id:University.first.id,user_id:us1.id,details:"aggg",likes:0,dislikes:0,date:DateTime.new(2016,1,1,1,1)})

ca = CarreerAnswer.create({carreer_question_id:cq.id, answer:"es cierto",likes:0,dislikes:0,date:DateTime.new(2016,1,1,1,1),user_id:us1.id })

ua = UniversityAnswer.create({university_question_id:uq.id, answer:"es cierto",likes:0,dislikes:0,date:DateTime.new(2016,1,1,1,1),user_id:us1.id })

nw = New.create({title:"SE LANZA GURUGOL", lowering:"Esta tarde se lanzo el sitio de apuestas mas grande del mundo", body:"Gurugol ha llegado en su primer dia a los 100.000 usuarios"})
end
=end

#===============================================================================
require 'csv'

def read_tsv file_name
  return CSV.read(
    Rails.root.join('lib', 'seeds', file_name), { headers: true,
                                                  col_sep: "\t", })
end

def read_csv file_name
  return CSV.read(
    Rails.root.join('lib', 'seeds', file_name), { headers: true,
                                                  col_sep: ",", })
end
require 'base64'

#to seed the db with encoded pictures
def encode_picture(file,output)
  enc = Base64.encode64(File.open(file,'rb'){|io| io.read})
  File.open(Rails.public_path.to_s +  '/images/'+ output,'w') do |f|
    enc.gsub!("\n",'')
    f.write enc
  end
end

if ENV['seed_pictures'] == '1'
  University.all.each do |u|
    u.profile_picture = u.id.to_s
    u.cover_picture = u.id.to_s
    u.profile_extension = "png"
    u.cover_extension = "png"
    puts "/images/seeds/cover/#{u.cover_picture}.#{u.cover_extension}"
    encode_picture(Rails.public_path.to_s + "/images/seeds/cover/#{u.cover_picture}.#{u.cover_extension}","universities/cover/#{u.id.to_s}")
    encode_picture(Rails.public_path.to_s + "/images/seeds/profile/#{u.profile_picture}.#{u.profile_extension}","universities/profile/#{u.id.to_s}")
    u.save
  end
  Area.all.each do |a|
    encode_picture(Rails.public_path.to_s + "/images/seeds/areas/#{a.id.to_s}.png","areas/#{a.id.to_s}")
  end

else
  cl = Country.create(title: 'Chile')
  s1 = Subject.create({title:"Lenguaje"})
  s2 = Subject.create({title:"Matemáticas"})
  s3 = Subject.create({title:"Historia"})
  s4 = Subject.create({title:"Ciencias Naturales"})

  # Region.create([
  #   { title: 'Tarapacá', country: cl },
  #   { title: 'Antofagasta', country: cl },
  #   { title: 'Atacama', country: cl },
  #   { title: 'Coquimbo', country: cl },
  #   { title: 'Valparaiso', country: cl },
  #   { title: 'O\'higgins', country: cl },
  #   { title: 'Maule', country: cl },
  #   { title: 'Bio-Bio', country: cl },
  #   { title: 'La Araucanía', country: cl },
  #   { title: 'Los Lagos', country: cl },
  #   { title: 'Aysén', country: cl },
  #   { title: 'Magallanes', country: cl },
  #   { title: 'Metropolitana', country: cl },
  #   { title: 'Los Ríos', country: cl },
  #   { title: 'Arica y Parinacota', country: cl },
  # ])

  # Cargar ciudades y regiones
  read_csv("ciudades_chile.csv").each do |row|
    puts "Ciudad y region #{row['ciudad']} , #{row['region']}"
    region = Region.find_or_create_by!(title: row['region'], country: cl )
    ciudad = City.create!(title: row['ciudad'] , region: region )
  end



  # exit()
  # Fin cargar ciudades y regiones




  l1 = Level.create!(title: 'High School')
  l2 = Level.create!(title: 'High School Graduate')
  l3 = Level.create!(title: 'Superior')
  l4 = Level.create!(title: 'Superior Graduate')

  it_1 = InstitutionType.create!(title: 'High School', level_id: l1.id)
  it_2 = InstitutionType.create!(title: 'University', level_id: l3.id)

  # Areas
  areas_hash = {}
  read_tsv('areas.tsv').each do |row|
    areas_hash[row['title']] = Area.create!(title: row['title'])
  end

  # University types
  university_types_hash = {}
  read_tsv('university_types.tsv').each do |row|
    university_types_hash[row['title']] = UniversityType.create!(title: row['title'])
  end

  # Universities
  boolean_hash = { 'Si' => true, 'No' => false }
  #encode_picture(Rails.public_path.to_s +  '/images/seed/puc.jpg','universities/' + profile_uc)
  covers = Dir[Rails.public_path.to_s +  '/images/seeds/cover']
  profiles = Dir[Rails.public_path.to_s +  '/images/seeds/profile']

  #covers_extensions = covers.map {|x| [File.basename(x,File.extname(x)),File.extname(x).strip.downcase[1..-1]]}.to_h
  #profiles_extensions = profiles.map {|x| [File.basename(x,File.extname(x)),File.extname(x).strip.downcase[1..-1]]}.to_h
  universities_hash = {}
  read_tsv('universidades.tsv').each do |row|
    University.create! do |u|
      u.id =                row['ID'],
      u.foundation =        row['Fundación'].to_datetime,
      u.website =           row['Sitio web'],
      u.freeness =          boolean_hash[row['Gratuidad']],
      u.motto =             row['Lema'],
      u.title =             row['Nombre']
      u.initials =          row['Sigla'],
      u.students =          row['Nro de Alumnos'],
      u.teachers =          row['Nro de Profesores'],
      u.degrees =           row['Numero de grados'],
      u.postgraduates =     row['Nro de post-grados'],
      u.doctorates =        row['Nro de doctorados'],
      u.description =       row['Descripción'],
      u.university_type =   university_types_hash[row['Tipo']],
      u.profile_picture = row['ID'],
      u.cover_picture = row['ID'],
      u.profile_extension = "png",
      u.cover_extension = "png"
      puts "/images/seeds/cover/#{u.cover_picture}.#{u.cover_extension}"
      encode_picture(Rails.public_path.to_s + "/images/seeds/cover/#{u.cover_picture}.#{u.cover_extension}","universities/cover/#{row['ID']}")
      encode_picture(Rails.public_path.to_s + "/images/seeds/profile/#{u.profile_picture}.#{u.profile_extension}","universities/profile/#{row['ID']}")
    end
    puts "[DEBUG] #{row['Nombre']}"
  end

  read_tsv('descripciones.tsv').each do |row|
    u = University.find_by(id: row['id'])
    u.description = row['description']
    u.save
  end


  campus_hash = {}
  read_tsv('campuses.tsv').each do |row|
    # FIX: Se está evitando crear algunos campus ya que el tsv se encuentra inc-
    # ompleto. Puedes dar cuenta de esto añadiendo "!" a los métodos "find_or_-
    # create_by" y "create".
    if row['Ciudad'] == nil
      next
    end
    city = City.find_or_create_by(title: row['Ciudad'], region_id: row['id_region'])

    Campu.create!(
      id:            row['ID'],
      title:         row['Nombre'],
      university_id: row['ID Universidad'],
      lat:           row['Latitud'],
      long:          row['Longitud'],
      address:       row['Dirección'],
      city:          city,
    )
  end

  certification_hash = { 'Si' => true, 'No' => false }

  # Falta terminar desde acá hacia abajo. Para probar en mi máquina lo que he e-
  # stado haciendo es:
  # $ rails db:drop && rails db:create && rails db:migrate && rails db:seed
  #
  # Debes asegurarte de que está corriendo el motor de búsqueda.
  # $ rails sunspot:solr:run
  #
  # NOTA: ¡Debes instalar Java Runtime Environment!

  degrees_hash = {}
  read_tsv('carreras.tsv').each do |row|
    puts "[DEBUG] Begin #{row['Nombre']}"
    car = Carreer.create!(
      title: row['Nombre'],
      university_id: row['ID Universidad'],
      campu_id: row['ID Campus'],
      certification: certification_hash[row['Acreditación']],
      openings: row['Vacantes'],
      semesters: row['Cant. Semestres'],
      price: row['Arancel'],
      area: areas_hash[row['Área']],
      schedule: row['Horario'],
      employability: row['Empleabilidad'],
      income: row['Ingreso'],
      admission: row['Admisión'],
      #TODO importante !!! se debe agregar soporte para los dos cortes
      last_cut: row['Corte 2017'],
      description: row['Descripción']
      )
    w = Weighing.create!(
      language: row['Lenguaje'],
      math: row['Matemáticas'],
      history: row['Historia (Cs. Sociales)'],
      science: row['Ciencias'],
      NEM: row['NEM'],
      ranking: row['Ranking'],
      carreer_id: car.id
      )
    # car.save
    w.carreer_id = car.id
    w.save
  end
end
