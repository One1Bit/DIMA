import SwiftUI

struct TaskView: View {
    @Binding var responseText: String
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Image("Profile")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .padding(40)
                    .offset(x: 0, y: -100)
            }
            
            HStack {
                NavigationLink {
                    PhotoView(responseText: $responseText)
                } label: {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 100))
                        .foregroundColor(.gray)
                }
                
                Button(action: {
                    ChatGPTApi.shared.sendRequestToChatGPT { result in
                        switch result {
                        case .success(let responseText):
                            DispatchQueue.main.async {
                                self.responseText = responseText
                            }
                        case .failure(let error):
                            print("Error: \(error)")
                        }
                    }
                }) {
                    Image(systemName: "gobackward")
                        .font(.system(size: 100))
                        .foregroundColor(.gray)
                }.padding(50)
            }
            
            Text(responseText)
                .padding()
        }
    }
}

