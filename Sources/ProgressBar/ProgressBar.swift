import SwiftUI

public enum CircularProgressStyle {
    case gradient
    case solid
    case dashed
    case glow
    case filled
}

public struct ProgressBar: View {

    public var progress: Double
    public var size: CGFloat = 200
    public var lineWidth: CGFloat = 14
    public var style: CircularProgressStyle = .gradient
    
    public init(progress: Double, size: CGFloat, lineWidth: CGFloat, style: CircularProgressStyle) {
        self.progress = progress
        self.size = size
        self.lineWidth = lineWidth
        self.style = style
    }

    public var body: some View {

        ZStack {

            backgroundCircle
            progressCircle
            centerContent
        }
        .frame(width: size, height: size)
    }
}
extension ProgressBar {

    var backgroundCircle: some View {

        Circle()
            .stroke(
                Color.gray.opacity(0.25),
                style: StrokeStyle(lineWidth: lineWidth)
            )
    }
}
extension ProgressBar {

    @ViewBuilder
    var progressCircle: some View {

        switch style {

        case .gradient:

            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    LinearGradient(
                        colors: [.blue, .purple],
                        startPoint: .leading,
                        endPoint: .trailing
                    ),
                    style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut, value: progress)

        case .solid:

            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    Color.blue,
                    style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))

        case .dashed:

            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    Color.orange,
                    style: StrokeStyle(
                        lineWidth: lineWidth,
                        lineCap: .round,
                        dash: [8,6]
                    )
                )
                .rotationEffect(.degrees(-90))

        case .glow:

            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    Color.blue,
                    style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
                )
                .shadow(color: .blue.opacity(0.6), radius: 10)
                .rotationEffect(.degrees(-90))

        case .filled:

            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    AngularGradient(
                        gradient: Gradient(colors: [.blue,.purple,.pink]),
                        center: .center
                    ),
                    style: StrokeStyle(lineWidth: lineWidth + 4)
                )
                .rotationEffect(.degrees(-90))
        }
    }
}
extension ProgressBar {

    var centerContent: some View {

        Group {

            if progress >= 1 {

                Image(systemName: "checkmark")
                    .font(.system(size: size * 0.25, weight: .bold))
                    .foregroundColor(.green)

            } else {

                Text("\(Int(progress * 100))%")
                    .font(.system(size: size * 0.22, weight: .bold))
                    .foregroundColor(.gray)
            }
        }
    }
}
