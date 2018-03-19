import Foundation

public struct Song {
    public var tempo: Int!
    public var beats: Int!
    public var rythm: Int!
    public var instruments: [String: [Note]]!
    
    public init() {
        self.tempo = 100
        self.beats = 4
        self.rythm = 4
        self.instruments = [String : [Note]]()
    }
}

/*
    SAMPLE JSON
 
{
    "info": {
        "tempo": 100,
        "beats": 4,
        "rythm": 4
    },
    "instruments": {
        "piano": [
        {
        "pitch": "c",
        "octave": 4,
        "time": 0
        },
        {
        "pitch": "d",
        "octave": 4,
        "time": 4
        },
        {
        "pitch": "e",
        "octave": 4,
        "time": 8
        },
        {
        "pitch": "f",
        "octave": 4,
        "time": 12
        },
        {
        "pitch": "g",
        "octave": 4,
        "time": 16
        },
        {
        "pitch": "g",
        "octave": 4,
        "time": 24
        }
        ],
        "guitar": [
        
        ],
        "drums": [
        
        ],
        "cello": [
        
        ]
    }
}
 */

