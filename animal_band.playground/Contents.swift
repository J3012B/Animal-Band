//: A SpriteKit based Playground

import PlaygroundSupport
import SpriteKit






let frameSize = CGSize(width: 500, height: 500)
PlaygroundSupport.PlaygroundPage.current.liveView = AnimalBandView(size: frameSize)
PlaygroundSupport.PlaygroundPage.current.needsIndefiniteExecution = true
