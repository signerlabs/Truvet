//
//  AnimatedLogoOrbit.swift
//  Truvet
//
//  Created by signerlabs.
//

import SwiftUI
import SpriteKit

struct AnimatedLogoOrbit: View {
    let images: [String]

    @State private var scene: AnimatedLogoOrbitScene?

    var body: some View {
        ZStack {
            if let scene {
                SpriteView(
                    scene: scene,
                    options: [.allowsTransparency]
                )
            }
        }
        .onAppear {
            setupScene()
        }
    }

    private func setupScene() {
        let newScene = AnimatedLogoOrbitScene()
        newScene.images = images
        newScene.scaleMode = .resizeFill
        scene = newScene
    }
}

class AnimatedLogoOrbitScene: SKScene {
    var images: [String] = []

    let dotsPerCircle = 23
    let numCircles = 4

    var outerCircleDots: [SKShapeNode] = []
    var nextIconIndex = 0
    var originalPositions: [CGPoint] = []

    let container = SKNode()

    private let gradient: [(angle: CGFloat, color: SKColor)] = [
        (0, SKColor(red: 26/255, green: 127/255, blue: 93/255, alpha: 1)), // right = AccentColor (dark green)
        (.pi / 2, SKColor(red: 52/255, green: 180/255, blue: 140/255, alpha: 1)), // top = bright green
        (.pi, SKColor(red: 80/255, green: 200/255, blue: 160/255, alpha: 1)), // left = light green
        (3 * .pi / 2, SKColor(red: 40/255, green: 150/255, blue: 115/255, alpha: 1)), // bottom = mid green
        (2 * .pi, SKColor(red: 26/255, green: 127/255, blue: 93/255, alpha: 1))  // right = AccentColor (dark green)
    ]

    override func didMove(to view: SKView) {
        self.backgroundColor = .clear
        physicsWorld.gravity = .zero
        anchorPoint = CGPoint(x: 0.5, y: 0.5)

        addChild(container)
        buildCircles()
        startRotation()
        animateNextIcon()
    }

    private func buildCircles() {
        let circles = generateCircles()
        var angleOffset: CGFloat = 0

        for (circleIndex, circle) in circles.enumerated() {
            for dotIndex in 0..<dotsPerCircle {
                var angle = (2 * .pi / CGFloat(dotsPerCircle) * CGFloat(dotIndex)) + angleOffset
                if angle > 2 * .pi { angle -= 2 * .pi }

                let position = CGPoint(x: circle.radius * cos(angle), y: circle.radius * sin(angle))

                let dot = SKShapeNode(circleOfRadius: circle.size)
                dot.position = position
                dot.fillColor = getColor(for: angle)
                dot.strokeColor = .clear
                dot.name = "dot-\(circleIndex)"
                dot.physicsBody = SKPhysicsBody(circleOfRadius: circle.size + 3)
                dot.physicsBody?.isDynamic = true
                dot.physicsBody?.affectedByGravity = false

                if circleIndex == 0 {
                    let step = Int(round(Double(dotsPerCircle) / Double(images.count)))

                    if dotIndex % step == 0 {
                        placeIconOnOuterCircle(for: dot)
                        outerCircleDots.append(dot)
                    }
                }

                container.addChild(dot)
                originalPositions.append(position)
            }

            angleOffset += 0.4
        }

        // icons should animate clockwise
        outerCircleDots.reverse()
    }

    private func placeIconOnOuterCircle(for dot: SKShapeNode) {
        // Create a circular mask - larger size to accommodate the scale-up animation
        let maskRadius: CGFloat = 40  // 40 → 160 after the 4x scale-up
        let mask = SKShapeNode(circleOfRadius: maskRadius)
        mask.fillColor = .white
        mask.strokeColor = .clear

        // Create crop node
        let cropNode = SKCropNode()
        cropNode.maskNode = mask
        cropNode.alpha = 0
        cropNode.name = "sprite"
        cropNode.setScale(0.25)  // Start at 1/4 so visual size stays at 10

        // Create image sprite
        let sprite = SKSpriteNode(imageNamed: images[outerCircleDots.count])

        // Set texture filtering mode to avoid blurriness
        sprite.texture?.filteringMode = .linear

        // Compute image size with an aspectFill effect
        let imageSize = sprite.size
        let scale = max((maskRadius * 2) / imageSize.width, (maskRadius * 2) / imageSize.height)
        sprite.size = CGSize(width: imageSize.width * scale, height: imageSize.height * scale)

        cropNode.addChild(sprite)
        dot.addChild(cropNode)
    }

    private func startRotation() {
        let rotate = SKAction.rotate(byAngle: .pi * -2, duration: 10)
        container.run(.repeatForever(rotate))
    }

    private func animateNextIcon() {
        let dot = outerCircleDots[nextIconIndex]

        dot.physicsBody? = SKPhysicsBody(circleOfRadius: 10)
        dot.physicsBody?.density = 110
        dot.physicsBody?.isDynamic = false

        let scaleIcon = SKAction.run {
            let a1 = SKAction.scale(to: 4.0 * 1.1, duration: 0.1)
            let a2 = SKAction.scale(to: 4.0, duration: 0.1)

            dot.run(.sequence([a1, a2]))

            if let cropNode = dot.childNode(withName: "sprite") as? SKCropNode {
                cropNode.alpha = 1
            }
        }

        let wait = SKAction.wait(forDuration: 1)

        let shrinkIcon = SKAction.run {
            let scale = SKAction.scale(to: 1.0, duration: 0.6)
            scale.timingFunction = SpriteKitTimingFunctions.easeInQuad
            dot.run(scale)

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.45) {
                if let cropNode = dot.childNode(withName: "sprite") as? SKCropNode {
                    let fade = SKAction.fadeAlpha(to: 0, duration: 0.1)
                    cropNode.run(fade)
                }
            }
        }

        // move dots back to their original position
        let moveDots = SKAction.run {
            for (i, surroundingDot) in self.container.children.enumerated()
            where !surroundingDot.position.isApproximatelyEqual(to: self.originalPositions[i])
            {
            let moveAction = SKAction.move(to: self.originalPositions[i], duration: 0.6)
            moveAction.timingFunction = SpriteKitTimingFunctions.easeInQuad
            surroundingDot.run(moveAction)
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                self.nextIconIndex = (self.nextIconIndex + 1) % self.outerCircleDots.count
                self.animateNextIcon()
            }
        }

        dot.run(.sequence([scaleIcon, wait, moveDots, shrinkIcon])) {
            dot.physicsBody?.isDynamic = true
        }
    }

    private func generateCircles() -> [(radius: CGFloat, size: CGFloat)] {
        let radiusStep = 15
        let initialRadius = 75
        var dotSize = 4

        var circles: [(CGFloat, CGFloat)] = []

        for circleIndex in 0..<numCircles {
            let radius = CGFloat(initialRadius + (circleIndex * radiusStep))
            circles.append((CGFloat(radius), CGFloat(dotSize)))

            if circleIndex == 0 {
                dotSize += 2
            } else if circleIndex % 2 == 0 {
                dotSize += 3
            } else {
                dotSize -= 1
            }
        }

        return Array(circles.reversed())
    }

    override func update(_ currentTime: TimeInterval) {
        for case let dot as SKShapeNode in container.children {
            let worldPos = container.convert(dot.position, to: self)
            var angle = atan2(worldPos.y, worldPos.x)

            // normalise from -pi...pi to 0...2pi
            if angle < 0 {
                angle += 2 * .pi
            }

            dot.fillColor = getColor(for: angle)
        }

        let dot = outerCircleDots[nextIconIndex]
        dot.zRotation = -container.zRotation
    }

    private func getColor(for angle: CGFloat) -> SKColor {
        guard let startIndex = gradient.lastIndex(where: { $0.angle <= angle }) else {
            return .white
        }

        let endIndex = startIndex + 1

        let start = gradient[startIndex]
        let end = gradient[endIndex]

        let percent = (angle - start.angle) / (end.angle - start.angle)

        let r = start.color.rgba.red + (end.color.rgba.red - start.color.rgba.red) * percent
        let g = start.color.rgba.green + (end.color.rgba.green - start.color.rgba.green) * percent
        let b = start.color.rgba.blue + (end.color.rgba.blue - start.color.rgba.blue) * percent

        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }

}

#Preview {
    // Asset names — these are images stored in Assets.xcassets and are not user-visible strings.
    AnimatedLogoOrbit(
        images: ["豆豆", "泡芙", "小白", "可乐", "bella", "lucky"]
    )
}
