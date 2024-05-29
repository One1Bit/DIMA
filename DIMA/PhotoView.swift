import SwiftUI

struct PhotoView: View {
    @Binding var responseText: String
    @State private var showImagePicker = false
    @State private var inputImage: UIImage?
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    
    var body: some View {
        VStack {
            Text("Challenge")
                .fontWeight(.bold)
            Text(responseText)
                .padding(50)
                .multilineTextAlignment(.center)
            Rectangle()
                .fill(Color.gray.opacity(0.5))
                .frame(width: 200, height: 150)
                .cornerRadius(5.0)
                .overlay(
                    inputImage.map { Image(uiImage: $0) }?
                        .resizable()
                        .scaledToFit()
                )
            
            HStack {
                Button(action: {
                    sourceType = .camera
                    showImagePicker = true
                }) {
                    VStack {
                        Image(systemName: "camera")
                            .font(.system(size: 50))
                            .foregroundColor(.gray)
                        Text("Take Photo")
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                
                Button(action: {
                    sourceType = .photoLibrary
                    showImagePicker = true
                }) {
                    VStack {
                        Image(systemName: "photo")
                            .font(.system(size: 50))
                            .foregroundColor(.gray)
                        Text("Upload Photo")
                            .foregroundColor(.gray)
                    }
                }
                .padding()
            }
            
            Button(action: {
                // add action (turn to next page)
            }) {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 100))
                    .foregroundColor(.gray)
            }
            .padding(50)
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: $inputImage, sourceType: sourceType)
        }
    }
}
