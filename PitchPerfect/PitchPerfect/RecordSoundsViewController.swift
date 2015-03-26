//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Sergei on 09/03/15.
//  Copyright (c) 2015 Sergei. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    @IBOutlet weak var recordingStateLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordingInProgressLabel: UILabel!
    
    var audioRecorder: AVAudioRecorder!
    //Declare variable to pass audio record file name and path to PlaySoundsViewController with RecordedAudio class.
    var recordedAudio: RecordedAudio!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        //Prepare view. Set labels text and state. Hide stop button.
        self.recordingStateLabel.text = "tap to record"
        recordingInProgressLabel.hidden = true
        stopButton.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        //Unwrap optionals, check if not nil.
        if(flag){
                recordedAudio = RecordedAudio(title: recorder.url.lastPathComponent!, filePathUrl: recorder.url)
                self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        }else{
            self.recordingStateLabel.text = "tap to record"
            recordingInProgressLabel.hidden = true
            stopButton.hidden = true
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //Prepare for segue and pass recorded file name and path data to PlaySoundsViewController.
        if (segue.identifier == "stopRecording"){
            let playSoundsVC: PlaySoundsViewController = segue.destinationViewController as PlaySoundsViewController
            let data = sender as RecordedAudio
            playSoundsVC.receivedAudio = data
        }
    }
    
    @IBAction func recordAudio(sender: UIButton){
        //Idea is to start/pause/resume with one button.
        //Since neither AVAudioRecorder() and file path properties is yet initialized check the label text to define pause/continue record condition.
        //Not the ideal solution as it's not checking AVAudioRecorder() state. By the time if statement is true audioRecorder is already initialized.
        if recordingStateLabel.text == "tap to pause"{
            self.recordingStateLabel.text = "tap to continue"
            self.recordingInProgressLabel.text = "recording paused"
            audioRecorder.pause()
        }else if recordingStateLabel.text == "tap to continue"{
            self.recordingStateLabel.text = "tap to pause"
            self.recordingInProgressLabel.text = "recording..."
            audioRecorder.record()
        }else{
            //Change labels text to reflect recorder state. Unhide stop button.
            self.recordingStateLabel.text = "tap to pause"
            self.recordingInProgressLabel.text = "recording..."
            recordingInProgressLabel.hidden = false
            stopButton.hidden = false
            
            //Set file name from current date/time. Prepare full path to file as URL.
            let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
            let currentDateTime = NSDate()
            let formatter = NSDateFormatter()
            formatter.dateFormat = "ddMMyyyy-HHmmss"
            let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
            let pathArray = [dirPath, recordingName]
            let filePath = NSURL.fileURLWithPathComponents(pathArray)
            
            //Setup audio session
            var session = AVAudioSession.sharedInstance()
            session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
            
            //Initilize, prepare and start the audio recorder.
            audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
            audioRecorder.delegate = self
            audioRecorder.meteringEnabled = true
            audioRecorder.prepareToRecord()
            audioRecorder.record()
        }
    }
    
    @IBAction func stopRecording(sender: UIButton) {
        //Stop recording and deactivate audio session instance
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
    }
}