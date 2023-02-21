addresses = [
  { street_number: "14", street_name: "rue Sébastopol", city: "Sainte-geneviève-des-bois", region: "Île-de-France", phone_number: "0138044146", zip_code: "91700", country: "France", latitude: "48.631090", longitude: "2.328740" },
  { street_number: "12", street_name: "boulevard Aristide Briand", city: "Le Grand-quevilly", region: "Haute-Normandie", phone_number: "0275140674", zip_code: "76120", country: "France", latitude: "49.398180", longitude: "1.026940" },
  { street_number: "14", street_name: "rue Clement Marot", city: "Pierrefitte-sur-seine", region: "Île-de-France", phone_number: "0126695645", zip_code: "93380", country: "France", latitude: "48.972980", longitude: "2.363420" },
  { street_number: "3", street_name: "Rue de la Cathédrale", city: "Limoges", region: "Limousin", phone_number: "0557886159", zip_code: "87000", country: "France", latitude: "45.827912", longitude: "1.264733" },
  { street_number: "54", street_name: "rue Sadi Carnot", city: "Auxerre", region: "Bourgogne", phone_number: "3489276134", zip_code: "89000", country: "France", latitude: "47.798202", longitude: "3.573781" },
  { street_number: "41", street_name: "Rue de Strasbourg", city: "Clichy", region: "Île-de-France", phone_number: "0178311852", zip_code: "92110", country: "France", latitude: "48.904526", longitude: "2.304768" },
  { street_number: "56", street_name: "rue de la République", city: "Lyon", region: "Rhône-Alpes", phone_number: "0429110723", zip_code: "69004", country: "France", latitude: "45.759119", longitude: "4.834679" },
  { street_number: "1", street_name: "boulevard Bryas", city: "Châteauroux", region: "Centre-Val de Loire", phone_number: "0368651632", zip_code: "36000", country: "France", latitude: "46.809015", longitude: "1.704621" },
  { street_number: "29", street_name: "boulevard Albin Durand", city: "Cergy", region: "Île-de-France", phone_number: "0120328851", zip_code: "95000", country: "France", latitude: "", longitude: "" },
  { street_number: "47", street_name: "Boulevard de Normandie", city: "Fontenay-sous-bois", region: "Île-de-France", phone_number: "0131951087", zip_code: "94120", country: "France", latitude: "", longitude: "" },
  { street_number: "78", street_name: "boulevard Bryas", city: "Dammarie-les-lys", region: "Île-de-France", phone_number: "0141813239", zip_code: "77190", country: "France", latitude: "", longitude: "" },
  { street_number: "25", street_name: "rue Grande Fusterie", city: "Brive-la-gaillarde", region: "Limousin", phone_number: "0521619530", zip_code: "19100", country: "France", latitude: "", longitude: "" },
  { street_number: "4", street_name: "place Stanislas", city: "Nantes", region: "Pays de la Loire", phone_number: "0222808580", zip_code: "44000", country: "France", latitude: "", longitude: "" },
  { street_number: "77", street_name: "avenue Voltaire", city: "Maisons-alfort", region: "Île-de-France", phone_number: "0550848258", zip_code: "64700", country: "France", latitude: "", longitude: "" },
  { street_number: "72", street_name: "Place Charles de Gaulle", city: "Villeneuve-d'ascq", region: "Nord-Pas-de-Calais", phone_number: "0340417026", zip_code: "59491", country: "France", latitude: "", longitude: "" },
  { street_number: "1", street_name: "Place du Jeu de Paume", city: "Villefranche-sur-saÔne", region: "Rhône-Alpes", phone_number: "0474981032", zip_code: "69400", country: "France", latitude: "", longitude: "" },
  { street_number: "66", street_name: "rue des Dunes", city: "Saint-malo", region: "Bretagne", phone_number: "0223307980", zip_code: "35400", country: "France", latitude: "", longitude: "" },
  { street_number: "53", street_name: "rue Beauvau", city: "Marseille", region: "Provence-Alpes-Côte d'Azur", phone_number: "0418639271", zip_code: "13005", country: "France", latitude: "", longitude: "" },
  { street_number: "59", street_name: "rue Pierre Motte", city: "Saint-dizier", region: "Champagne-Ardenne", phone_number: "0360623982", zip_code: "52100", country: "France", latitude: "", longitude: "" },
  { street_number: "22", street_name: "boulevard de la Liberation", city: "Marseille", region: "Provence-Alpes-Côte d'Azur", phone_number: "0412136542", zip_code: "13013", country: "France", latitude: "", longitude: "" },
]

if Address.count.zero?
  p "Seeding Addresses for properties"
  Property.all.each do |property|
    address = addresses[property.id]
    property.address = Address.create(line_one: "#{address[:street_number]} #{address[:street_name]}",
                                      city: address[:city], zip_code: address[:zip_code], country: address[:country])
  end

  p "Seeding Address for Ferme Autonome"
  Property.find_by_name("Ferme autonome")
          .address.update_columns(line_one: "2 Mondehard", city: "Seulline", phone_number: "0212136542", zip_code: "14310",
                                  country: "France")
end
