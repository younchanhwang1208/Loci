import SwiftUI

extension Font {
    static func helvetica(size: CGFloat) -> Font {
        return Font.custom("Helvetica", size: size)
    }
}

struct MixedVsFull: View {
    @State private var isHovering = false
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Button("Mixed Reality: Coming Soon") {

                    // Future implementation
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    Image("stars")
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.height/2)
                        .opacity(0.5)
                        .overlay(Color.black.opacity(0.3)))
                .buttonStyle(PlainButtonStyle())
                .foregroundColor(.white)
                .font(.title)
                .cornerRadius(10)
                .padding(EdgeInsets(top: 16, leading: 16, bottom: 8, trailing: 16))
                NavigationLink(destination: PlaceObjects(spaceTitle: "Among Us Immersive Space", imageName: "amongus_minimap")) {
                    ZStack{
                        Image("amongus_button")
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width, height: geometry.size.height/2)
                            .opacity(0.5)
                            .onHover { hovering in
                                print("hovering on")
                                isHovering = hovering
                            }
                            .scaleEffect(isHovering ? 1.7 : 1.0)
                            .overlay(Color.black.opacity(0.3))
                            
                            //.animation(.easeInOut(duration: 0.3), value: isHovering)
                        Text("Full Immersion")
                            .foregroundColor(.white)
                            .font(.title)
                            .hoverEffect(.lift)
                    }
                } //NavigationLink
                .buttonStyle(PlainButtonStyle())
                .cornerRadius(10)
                .padding(EdgeInsets(top: 8, leading: 16, bottom: 16, trailing: 16))
            }
        }

    }
}

#Preview {
    MixedVsFull()
}
