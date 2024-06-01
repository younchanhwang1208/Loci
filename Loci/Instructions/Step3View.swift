import SwiftUI

struct Step3View: View {
    var body: some View {
        VStack {
            Text("Choose a List to Memorize")
                .font(.largeTitle)
                .padding(.bottom, 15)

            Text("""
            - Each room has predefined totem locations where you can place items.
            - These locations are placed to help you recall the items effectively.
            - Select from predefined lists such as countries, capitals, or historical dates.
            - You can also create your own custom lists. Make sure to follow the specific format provided.
            """)
            .padding(.bottom, 30)

            NavigationLink(destination: MapNav()) {
                Text("Start Creating Pairs")
                    .padding()
                    .cornerRadius(10)
            }
        }
        .padding(70)
    }
}

#Preview {
    Step3View()
}
