from typing import Sequence, Union
from vapoursynth import core, VideoNode, AudioNode

# Example usage:
#
# from trim import Trim
#
# vclip = core.ffms2.Source("espn.mp4")
# aclip = core.bas.Source("espn.mp4")
#
# vclip, aclip = ( \
#     Trim((vclip, aclip), 2000, 2497) + \
#     Trim((vclip, aclip), 15000, 15400) + \
#     Trim((vclip, aclip), 5000, 5400) \
#     ).data()
#
# vclip.set_output(0)
# aclip.set_output(1)


class Trim:
    def __init__(self, clip: Union[AudioNode, Sequence], start: int = None, end: int = None, fps: Sequence = None) -> Union[AudioNode, tuple]:
        """ Convenient wrapper for trimming audio samples by frame numbers """
        if not start and not end:
            raise ValueError('Trim: missing "start" and/or "end" options.')

        self.vclip, self.aclip = None, None
        self.mode = 'audio'

        if isinstance(clip, Sequence) and len(clip) == 2:
            self.mode = 'video_audio'
            self.vclip, self.aclip = clip
            assert isinstance(
                self.vclip, VideoNode), 'Trim: first clip must be video.'
            assert isinstance(
                self.aclip, AudioNode), 'Trim: second clip must be audio.'
            self.vclip = core.std.Trim(self.vclip, start, end)

        elif isinstance(clip, AudioNode):
            self.aclip = clip
            if not fps:
                raise ValueError('Trim: missing "fps" option.')
        else:
            raise ValueError(
                'Trim: clip must be audio type or sequence with video and audio clips.')
        if isinstance(self.vclip, VideoNode) and not (self.vclip.fps.numerator == 0 and self.vclip.fps.denominator == 0) and fps is None:
            fps = (self.vclip.fps.numerator, self.vclip.fps.denominator)
        samples_per_video_frame = self.aclip.sample_rate / fps[0] * fps[1]
        audio_start, audio_end = start * \
            samples_per_video_frame, end * samples_per_video_frame
        self.aclip = core.std.AudioTrim(self.aclip, audio_start, audio_end)

    def __add__(self, other):
        if not isinstance(other, Trim):
            raise ValueError(f'Trim: impossible to operate on non-Trim inputs.')
        if self.mode == 'video_audio' and other.mode != 'video_audio':
            raise ValueError(
                'Trim: add failed. Probably you\'re mixing inconsistent instances (audio + video and audio or so).')
        if self.mode == 'video_audio':
            self.vclip += other.vclip
        self.aclip += other.aclip
        return self

    def data(self):
        if self.mode == 'video_audio':
            return self.vclip, self.aclip
        else:
            return self.aclip
