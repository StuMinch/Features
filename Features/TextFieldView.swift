import SwiftUI

struct TextFieldView: View {
    @State private var inputText = ""
    @State private var showBanner = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                TextField("Enter your text here", text: $inputText)
                    .textFieldStyle(.roundedBorder)
                    .padding()

                Button("Submit") {
                    // Handle the submitted text here
                    print("Submitted text: \(inputText)")
                }
                .padding()
                .background(Color(red: 0, green: 0, blue: 0.5))
                .foregroundStyle(.white)
                .clipShape(Capsule())

                Button("Back") {
                    presentationMode.wrappedValue.dismiss()
                }
                .padding()
                .background(Color(red: 0.5, green: 0, blue: 0))
                .foregroundStyle(.white)
                .clipShape(Capsule())
            }
            .padding()

            if showBanner {
                PromotionalBannerView()
                    .transition(.move(edge: .bottom))
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                withAnimation(.easeInOut(duration: 0.6)) {
                    showBanner = true
                }
            }
        }
    }
}

struct PromotionalBannerView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Special Offer!")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.white)

            Text("Unlock exclusive features and save big today!")
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundStyle(.white.opacity(0.9))

            Button("Claim Now") {
                // Handle offer claim
            }
            .padding(.horizontal, 32)
            .padding(.vertical, 12)
            .background(Color.white)
            .foregroundStyle(Color(red: 0, green: 0.55, blue: 0.2))
            .clipShape(Capsule())
            .fontWeight(.bold)
        }
        .padding(.horizontal, 24)
        .padding(.top, 32)
        .padding(.bottom, 48)
        .frame(maxWidth: .infinity)
        .background(
            UnevenRoundedRectangle(
                topLeadingRadius: 24,
                bottomLeadingRadius: 0,
                bottomTrailingRadius: 0,
                topTrailingRadius: 24
            )
            .fill(
                LinearGradient(
                    colors: [Color(red: 0, green: 0.7, blue: 0.3), Color(red: 0, green: 0.45, blue: 0.2)],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
        )
    }
}

#Preview {
    TextFieldView()
}
