BestAudioSource thread:
https://forum.doom9.org/showthread.php?t=177337

Sample Script:
import vapoursynth as vs
core = vs.core

clip = core.ffms2.Source("espn.mp4")
audio = core.bas.Source("espn.mp4")

one = core.std.Trim(clip, 0, 2497)
aone = core.std.AudioTrim(audio, 0, 4410000)

one.set_output(0)
aone.set_output(1)
