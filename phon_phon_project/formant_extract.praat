# Extracts French vowel formants from TextGrids
# aligned using SPPAS
#
# -Joshua McNeill
# joshua dot mcneill at uga dot edu

# Make sure the text encoding is UTF-8
Text writing preferences: "UTF-8"
Text reading preferences: "try UTF-8, then Windows Latin-1"

writeInfoLine: "DISCLAIMER: This may take a minute."

sound$ = selected$("Sound")
grid$ = selected$("TextGrid")
out_file$ = "./data/formants_" + grid$ - "-merge" + ".csv"
writeFileLine: out_file$, "PHONEME,F1,F2,F3,WORD,SPEAKER"

selectObject: "TextGrid " + grid$
phoneme_count = Get number of intervals: 3

appendInfoLine: "Creating Formant object..."
selectObject: "Sound " + sound$
To Formant (burg): 0, 5, 5000, 0.025, 50

appendInfoLine: "Getting vowel formants..."
for interval from 1 to phoneme_count
  selectObject: "TextGrid " + grid$
  phoneme$ = Get label of interval: 3, interval
  if phoneme$ = "i" or phoneme$ = "y" or phoneme$ = "e" or phoneme$ = "2" or
    ... phoneme$ = "E" or phoneme$ = "9" or phoneme$ = "a" or phoneme$ = "u" or
    ... phoneme$ = "o" or phoneme$ = "O" or phoneme$ = "A" or phoneme$ = "@" or
    ... phoneme$ = "a~" or phoneme$ = "O~" or phoneme$ = "U~/" or phoneme$ = "O/" or
    ... phoneme$ = "A/"
    start = Get start point: 3, interval
    end = Get start point: 3, interval
    duration = end - start
    midpoint = start + duration/2

    word_interval = Get interval at time: 4, midpoint
    word$ = Get label of interval: 4, word_interval

    selectObject: "Formant " + sound$
    f1 = Get value at time: 1, midpoint, "hertz", "Linear"
    f2 = Get value at time: 2, midpoint, "hertz", "Linear"
    f3 = Get value at time: 3, midpoint, "hertz", "Linear"
    appendFileLine: out_file$, phoneme$, ",", f1, ",", f2, ",", f3, ",", word$, ",", grid$ - "-merge"
  endif
endfor

# Clean-up
selectObject: "Formant " + sound$
Remove

appendInfoLine: "All done!"
appendInfoLine: "Saved to " + out_file$
