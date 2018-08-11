#!/bin/bash -el

snapserver -s "pipe:///tmp/snapfifo?name=Radio&sampleformat=44100:16:2"
