import Foundation

func makePOSTRequest(viewModel: EventViewModel) {
    guard let url = URL(string: "http://5f5a8f24d44d640016169133.mockapi.io/api/checkin") else { return }
    
    var request = URLRequest(url: url)
    
    request.httpMethod = "POST"
    let body: [String: String] = [
        "eventId": "\(viewModel.id)",
        "name": "Tatiane Toth",
        "email": "tatiane.toth@gmail.com",
    ]
    request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
    
    URLSession.shared.dataTask(with: request) { data, _, error in
        guard let data = data, error == nil else { return }
        
        do {
            guard let response = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) else { return }
                    print("SUCESS: \(String(describing: response))")
        }
        catch {
            print(error)
        }
    }.resume()
}
