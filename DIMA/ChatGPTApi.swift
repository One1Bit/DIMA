import Foundation
import Alamofire

class ChatGPTApi {
    static let shared = ChatGPTApi()
    
    private let apiUrl = "https://api.openai.com/v1/chat/completions"
    private let apiKey: String
    init() {
            guard let apiKey = ProcessInfo.processInfo.environment["OPENAI_API_KEY"] else {
                fatalError("API Key not found in environment variables")
            }
            self.apiKey = apiKey
        }
    
    func sendRequestToChatGPT(completion: @escaping (Result<String, Error>) -> Void) {
        let parameters: [String: Any] = [
            "model": "gpt-3.5-turbo",
            "messages": [
                [
                    "role": "user",
                    "content": "Create me an interesting task to do, it must be simple and fun, and I must finish it within 5 min. Write me only the task, no additional writing."
                ]
            ]
        ]
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(apiKey)"
        ]
        
        AF.request(apiUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                if let json = value as? [String: Any], let choices = json["choices"] as? [[String: Any]], let firstChoice = choices.first, let message = firstChoice["message"] as? [String: Any], let text = message["content"] as? String {
                    completion(.success(text))
                } else {
                    completion(.failure(NSError(domain: "InvalidResponse", code: 0, userInfo: nil)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
