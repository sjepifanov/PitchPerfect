# Pitch-perfect.
## First project of Udacity iOS Nanodegree

*NB! The project is written with Swift 1.2 and won't compile with Swift 2.2*

The Pitch Perfect app allows users to record a sound using the device’s microphone. It then allows users
to play the recorded sound back with six different sound modulations:
- Chipmunk
- Darth Vader
- Super Slow
- Super Fast
- Echo
- Reverberation

The app has two view controller scenes.

**Record Sounds View:** Allows users to record a sound.

**Play Sounds View:** Allows users to play the recorded sound back with effects.

## Record Sounds View

The record sounds view is the initial view for the app, and consists of a button with a microphone image.
A label indicating the user to tap the button to start recording should be added beneath the image (not pictured).
Tapping this microphone button will start an audio recording session.
The app will use code from AVFoundation to record sounds from the microphone.

Tapping the button will disable the record button, display a “recording” label, and present a stop button.
User is able to pause and restart recordings in addition to stopping them.

When the stop button is clicked, the app will complete its recording and then push the second scene
(described below under “Play Sounds View”) onto the navigation stack.

## Play Sounds View

The play sounds view has six buttons to play the recorded sound file and a button to stop the playback.

The buttons for playing the recorded sounds will have images corresponding to their sound effect:
- Chipmunk image → High-pitched sound
- Darth Vader image →  Low-pitched sound
- Snail image → Slow sound
- Rabbit image → Fast sound
- Parrot image → Echo sound
- Circular waves image → Reverberation

The play sounds view will have been pushed onto the navigation stack. At the top left of the screen,
the navigation bar’s left button says “Record”.
Clicking this button will pop the play sounds view off the stack and return the user to the record sounds view
(which is the default behavior of the navigation bar).
At this point, the play sounds view is in its original state. The microphone button is enabled and the stop button
is hidden.
