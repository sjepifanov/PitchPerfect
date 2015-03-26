//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Sergei on 18/03/15.
//  Copyright (c) 2015 Sergei. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audioPlayer: AVAudioPlayer!
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!
    //Recieve recorded file name and path from RecordSoundsViewController.
    var receivedAudio: RecordedAudio!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
        audioEngine = AVAudioEngine()
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func stopAudioPlayerAndEngine(){
        //Stop audio player. Stop and reset audio engine.
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    
    func playAudioWithSetRate(rate: Float){
        stopAudioPlayerAndEngine()
        
        //Play audio at set rate from starting position.
        audioPlayer.rate = rate
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    
    func playAudioWithEffect(effect: NSObject){
        stopAudioPlayerAndEngine()
        
        //Play audio with effect applied.
        //Initialize AVPlayerNode and get other nodes as 'effect' from @IBActions.
        //Connect player node through 'effect' to audio engine output node, start audio engine and play file.
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        audioEngine.attachNode(effect as AVAudioNode)
        
        audioEngine.connect(audioPlayerNode, to: effect as AVAudioNode, format: nil)
        audioEngine.connect(effect as AVAudioNode, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        audioPlayerNode.play()
        
    }
    
    @IBAction func playSlowAudio(sender: UIButton) {
        //Play audio at half speed.
        playAudioWithSetRate(0.5)
    }
    
    @IBAction func playFastAudio(sender: UIButton) {
        //Play audio at double speed.
        playAudioWithSetRate(2.0)
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        //Play audio at higher pitch.
        var highPitchEffect = AVAudioUnitTimePitch()
        highPitchEffect.pitch = 1000
        playAudioWithEffect(highPitchEffect)
    }
    
    @IBAction func playDarthVaderAudio(sender: UIButton) {
        //P audio at lower pitch.
        var lowPitchEffect = AVAudioUnitTimePitch()
        lowPitchEffect.pitch = -1000
        playAudioWithEffect(lowPitchEffect)
    }
    
    @IBAction func playReverbAudio(sender: UIButton) {
        //Play audio with reverberation effect.
        var reverbEffect = AVAudioUnitReverb()
        reverbEffect.loadFactoryPreset(.LargeRoom2)
        reverbEffect.wetDryMix = 70
        playAudioWithEffect(reverbEffect)
    }

    @IBAction func playEchoAudio(sender: UIButton) {
        //Play audio with delay effect.
        var delayEffect = AVAudioUnitDelay()
        delayEffect.delayTime = 0.7
        playAudioWithEffect(delayEffect)
    }
    
    @IBAction func stopAudio(sender: UIButton) {
        stopAudioPlayerAndEngine()
    }

}