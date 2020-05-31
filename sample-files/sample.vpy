import sys
import os
import vapoursynth as vs
core = vs.get_core()

# Import Scripts Folder
scriptPath = '/usr/share/vsscripts'
sys.path.append(os.path.abspath(scriptPath))
import havsfunc as hf
import mvsfunc as mf

core = vs.get_core()

clip = core.std.BlankClip(length=1000, format=vs.YUV420P8)
clip = hf.QTGMC(clip, Preset='Placebo', TFF=True)

clean = mf.BM3D(clip, sigma=20)

diff = core.std.MakeDiff(clip, clean)
diff = hf.SmoothLevels(diff, input_low=127, input_high=129, output_low=0, output_high=255)

clip = core.std.Interleave(clips=[clip, clean, diff])
clip.set_output()
