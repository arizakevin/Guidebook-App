//
//  DetailView.swift
//  Guidebook
//
//  Created by Kevin Ariza on 5/09/23.
//

import SwiftUI

struct DetailView: View {
    
    var attraction: Attraction
    
    var body: some View {
        
        VStack (spacing: 20) {
            Image(attraction.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 300)
                
            ScrollView (showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    Text(attraction.name)
                        .font(.title)
                        .bold()
                    
                    Text(attraction.longDescription)
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                    
                    
                    // Render "Get Directions" button if the URL can be created and opened.
                    if let url = createMapURL(name: attraction.name, latLong: attraction.latLong) {
                        if UIApplication.shared.canOpenURL(url) {
                            Button {
                                UIApplication.shared.open(url)
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 15)
                                        .foregroundColor(.blue)
                                        .frame(height: 40)
                                    
                                    Text("Get Directions")
                                        .foregroundColor(.white)
                                }
                            }
                        }
                    }
                }
                .padding(.bottom, 30)
            }
            .padding(.horizontal)
        }
        .ignoresSafeArea()
    }
    
    func cleanName(name: String) -> String {
        return name.replacingOccurrences(of: " ", with: "+")
            .folding(options: .diacriticInsensitive, locale: .current)
    }
    
    func cleanCoordinates(latLong: String) -> String {
        return latLong.replacingOccurrences(of: " ", with: "")
    }
    
    func createMapURL(name: String, latLong: String) -> URL? {
        let cleanedName = cleanName(name: name)
        let cleanedLatLong = cleanCoordinates(latLong: latLong)
        guard let url = URL(string: "maps://?q=\(cleanedName)&sll=\(cleanedLatLong)&z=10") else {
            print("Cannot create URL.")
            return nil
        }
        return url
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(attraction: Attraction(name: "Pantheon",
                                          summary: "The Pantheon is a former Roman temple and, since 609 AD, a Catholic church in Rome, Italy, on the site of an earlier temple commissioned by Marcus Agrippa during the reign of Augustus.",
                                          longDescription: """
       The Pantheon from Greek is a former Roman temple and, since 609 AD, a Catholic church (Basilica di Santa Maria ad Martyres or Basilica of St. Mary and the Martyrs) in Rome, Italy, on the site of an earlier temple commissioned by Marcus Agrippa during the reign of Augustus (27 BC – 14 AD). It was rebuilt by the emperor Hadrian and probably dedicated c. 126 AD. Its date of construction is uncertain, because Hadrian chose not to inscribe the new temple but rather to retain the inscription of Agrippa's older temple, which had burned down.
       """,
                                          imageName: "pantheon", latLong: "41.898762500696236, 12.476915812472798"))
    }
}
