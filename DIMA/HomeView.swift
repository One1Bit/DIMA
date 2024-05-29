import SwiftUI

struct HomeView: View {
    @State private var isPressed: Bool = false
    @State private var responseText: String = ""
    @State private var moveToTask: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 90) {
                HStack{
                    Spacer()
                        .frame(width: 270)
                    Image("Profile")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .scaledToFill()
                        .clipShape(Circle())
                }
                Spacer()
                    .frame(height: 20)
                Text("Don’t know what to do?")
                    .scaledToFill()
                Spacer()
                    .frame(height: 10)
                Text("Press the button below to generate a task and finish it!")
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                
                // Start button
                Button(action: {
                    print("Button pressed")
                    ChatGPTApi.shared.sendRequestToChatGPT { result in
                        switch result {
                        case .success(let responseText):
                            DispatchQueue.main.async {
                                self.responseText = responseText
                                self.moveToTask = true
                            }
                        case .failure(let error):
                            print("Error: \(error)")
                        }
                    }
                }) {
                    Image(systemName: "button.programmable")
                        .font(.system(size: 100))
                        .foregroundColor(.black)
                        .overlay(
                            Text("Start")
                                .foregroundColor(.white)
                        )
                }
                
                NavigationLink(destination: TaskView(responseText: $responseText), isActive: $moveToTask) {
                    EmptyView()
                }
            }
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

