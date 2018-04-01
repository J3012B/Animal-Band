//: A SpriteKit based Playground

import PlaygroundSupport
import SpriteKit


let audienceApplauses = true



let frameSize = CGSize(width: 700, height: 700)
PlaygroundSupport.PlaygroundPage.current.liveView = AnimalBandView(size: frameSize, audienceApplauses: audienceApplauses)
PlaygroundSupport.PlaygroundPage.current.needsIndefiniteExecution = true
