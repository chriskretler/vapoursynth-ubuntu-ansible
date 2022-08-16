8/15/2022: Will be most useful when paired with an editing helper script that figures out the sample rate of the input audio and allow you to pass frames to it, will edit based on those frames and computes the appropriate sample locations and edits there as well.

BestAudioSource thread:
https://forum.doom9.org/showthread.php?t=177337

Example usage, including ffmpeg:
https://forum.doom9.net/showthread.php?p=1969303#post1969303

Sample Script:
```
import vapoursynth as vs
core = vs.core

clip = core.ffms2.Source("espn.mp4")
audio = core.bas.Source("espn.mp4")

one = core.std.Trim(clip, 0, 2497)
aone = core.std.AudioTrim(audio, 0, 4410000)

one.set_output(0)
aone.set_output(1)
```

Sample ffmpeg:
```
vspipe -o 1 -c wav audio.vpy - | ffmpeg -i pipe: -c:a pcm_f32le espn_audio.wav
```
