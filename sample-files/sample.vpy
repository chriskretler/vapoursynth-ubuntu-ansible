import sys
import os
import vapoursynth as vs
core = vs.get_core()

# Import Scripts Folder
scriptPath = '/usr/share/vsscripts'
sys.path.append(os.path.abspath(scriptPath))
import havsfunc as haf

core = vs.get_core()

clip = core.std.BlankClip(length=1000, format=vs.YUV420P8)
clip = haf.QTGMC(clip, Preset='Placebo', TFF=True)
clip.set_output() 
