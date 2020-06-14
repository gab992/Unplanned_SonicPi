temp = 0.4

piano_pan = 0.5
synth_pan = -0.5
bass_pan = 0.25
chord_pan = -0.25

define :improv_E do
  use_synth :piano
  play choose([:E5,:Gs5,:B5,:Ds5,:E6,:Gs6,:B6,:Ds6]), pan:piano_pan
end

define :improv_A do
  use_synth :piano
  play choose([:A5,:C5,:E5,:G5,:A6,:C6,:E6,:G6]), pan:piano_pan
end

define :improv_F do
  use_synth :piano
  play choose([:Fs5,:A5,:Cs5,:E5,:Fs6,:A6,:Cs6,:E6]), pan:piano_pan
end

define :improv_G do
  use_synth :piano
  play choose([:G5,:B5,:D5,:E5,:G6,:B6,:D6,:E6]), pan:piano_pan
end

define :bass_E do
  use_synth :beep
  play choose([:E2,:Gs2,:B2,:Ds2]), attack:0, release:0.4, pan:bass_pan
end

define :bass_A do
  use_synth :beep
  play choose([:A2,:C2,:E2,:G2]), attack:0, release:0.4, pan:bass_pan
end

define :bass_F do
  use_synth :beep
  play choose([:Fs2,:A2,:Cs2,:E2]), attack:0, release:0.4, pan:bass_pan
end

define :bass_G do
  use_synth :beep
  play choose([:G2,:B2,:D2,:E2]), attack:0, release:0.4, pan:bass_pan
end

define :drum do
  maybe = 0
  if one_in(6)
    sample :drum_snare_hard
    sample :drum_heavy_kick
    sample :drum_cymbal_open
    maybe = 1
  else
    sample :drum_snare_soft
    sample :drum_cymbal_closed, amp:0.5
  end
  if maybe and one_in(3)
    if one_in(4)
      sleep temp/1.5
      sample :drum_tom_hi_soft
      sleep temp/3
      sample :drum_tom_mid_soft
      sleep temp/3
      sample :drum_tom_lo_soft
      sleep temp/3
      sample :drum_snare_hard
      sample :drum_heavy_kick
      sample :drum_cymbal_open
      sleep temp/3
    else
      sleep temp/1.5
      sample :drum_cymbal_soft
      sample :drum_heavy_kick
      sleep temp/1.5
      sample :drum_heavy_kick
      sample :drum_snare_hard
      sleep temp/1.5
    end
  else
    sleep temp/3
    sample :drum_cymbal_closed, amp:0.75
    sleep temp/3
    sample :drum_cymbal_closed, amp:0.4
    sleep temp/3
    sample :drum_cymbal_closed, amp:0.75
    sleep temp/3
    sample :drum_cymbal_closed, amp:0.4
    if one_in(3)
      sample :drum_snare_soft, amp:0.5
    end
    sleep temp/3
    sample :drum_cymbal_closed
    if one_in(2)
      sample :drum_snare_soft, amp:0.7
    end
    sleep temp/3
  end
end

i=0
dir='asc'
ps = 2
acomp=4
6.times do
  use_synth :fm
  play choose([:E3,:E4]), amp:0.75, pan:chord_pan
  play choose([:Gs3,:Gs4,:Gs5]), amp:0.75, pan:chord_pan
  play choose([:B3,:B4,:B5]), amp:0.75, pan:chord_pan
  play choose([:Ds4,:Ds5]), amp:0.75, pan:chord_pan
  in_thread do
    if one_in(acomp)
      use_synth :chiplead
      play choose([:E3,:E4,:Gs4,:Gs5,:Ds4,:Ds5,:B3,:B4,:B5]), pan:synth_pan
      if one_in(acomp)
        sleep temp/3
        play choose([:E3,:E4,:Gs4,:Gs5,:Ds4,:Ds5,:B3,:B4,:B5]), pan:synth_pan
      end
    end
    sleep 3*temp
    if one_in(acomp)
      play choose([:E3,:E4,:Gs4,:Gs5,:Ds4,:Ds5,:B3,:B4,:B5]), pan:synth_pan
      if one_in(acomp)
        sleep temp/3
        play choose([:E3,:E4,:Gs4,:Gs5,:Ds4,:Ds5,:B3,:B4,:B5]), pan:synth_pan
      end
    end
  end
  t = choose ([4*temp,6*temp,8*temp])
  n = t/(temp/3)
  d = n/6
  b = n/3
  in_thread do
    n.times do
      if one_in(ps)
        sleep temp/3
      else
        improv_E
        if one_in(ps+16)
          sleep temp/6
          improv_E
          sleep temp/6
        else
          sleep temp/3
        end
      end
    end
  end
  in_thread do
    d.times do
      drum
    end
  end
  in_thread do
    bassE = [:E2,:Gs2,:B2,:Ds2,:E3,:Gs3,:B3,:Ds3]
    b.times do
      use_synth :beep
      play bassE[i], attack:0, release:0.4, pan:bass_pan
      if i < 7
        i+=1
      else
        i=0
      end
      sleep temp
    end
  end
  sleep t
  play choose([:A3,:A4]), amp:0.75, pan:chord_pan
  play choose([:C3,:C4,:C5]), amp:0.75, pan:chord_pan
  play choose([:E3,:E4,:E5]), amp:0.75, pan:chord_pan
  play choose([:G4,:G5]), amp:0.75, pan:chord_pan
  in_thread do
    if one_in(acomp)
      use_synth :chiplead
      play choose([:A3,:A4,:C3,:C4,:C5,:E3,:E4,:E5,:G4,:G5]), attack:0, release:0.2, pan:synth_pan
      if one_in(acomp)
        sleep temp/3
        play choose([:A3,:A4,:C3,:C4,:C5,:E3,:E4,:E5,:G4,:G5]), attack:0, release:0.2, pan:synth_pan
      end
    end
    sleep 3*temp
    if one_in(acomp)
      play choose([:A3,:A4,:C3,:C4,:C5,:E3,:E4,:E5,:G4,:G5]), attack:0, release:0.2, pan:synth_pan
      if one_in(acomp)
        sleep temp/3
        play choose([:A3,:A4,:C3,:C4,:C5,:E3,:E4,:E5,:G4,:G5]), attack:0, release:0.2, pan:synth_pan
      end
    end
  end
  t = choose ([4*temp,6*temp,8*temp])
  n = t/(temp/3)
  d = n/6
  b = n/3
  in_thread do
    n.times do
      if one_in(ps)
        sleep temp/3
      else
        improv_A
        if one_in(ps+16)
          sleep temp/6
          improv_A
          sleep temp/6
        else
          sleep temp/3
        end
      end
    end
  end
  in_thread do
    d.times do
      drum
    end
  end
  in_thread do
    bassA = [:A2,:C2,:E2,:G2,:A3,:C3,:E3,:G3]
    b.times do
      use_synth :beep
      play bassA[i], attack:0, release:0.4, pan:bass_pan
      if i < 7
        i+=1
      else
        i=0
      end
      sleep temp
    end
  end
  sleep t
  play choose([:Fs3,:Fs4]), amp:0.75, pan:chord_pan
  play choose([:A3,:A4,:A5]), amp:0.75, pan:chord_pan
  play choose([:Cs3,:Cs4,:Cs5]), amp:0.75, pan:chord_pan
  play choose([:E4,:E5]), amp:0.75, pan:chord_pan
  in_thread do
    if one_in(acomp)
      use_synth :chiplead
      play choose([:Fs3,:Fs4,:A3,:A4,:A5,:Cs3,:Cs4,:Cs5,:E4,:E5]), attack:0, release:0.2, pan:synth_pan
      if one_in(acomp)
        sleep temp/3
        play choose([:Fs3,:Fs4,:A3,:A4,:A5,:Cs3,:Cs4,:Cs5,:E4,:E5]), attack:0, release:0.2, pan:synth_pan
      end
    end
    sleep 3*temp
    if one_in(acomp)
      play choose([:Fs3,:Fs4,:A3,:A4,:A5,:Cs3,:Cs4,:Cs5,:E4,:E5]), attack:0, release:0.2, pan:synth_pan
      if one_in(acomp)
        sleep temp/3
        play choose([:Fs3,:Fs4,:A3,:A4,:A5,:Cs3,:Cs4,:Cs5,:E4,:E5]), attack:0, release:0.2, pan:synth_pan
      end
    end
  end
  t = choose ([4*temp,6*temp,8*temp])
  n = t/(temp/3)
  d = n/6
  b = n/3
  in_thread do
    n.times do
      if one_in(ps)
        sleep temp/3
      else
        improv_F
        if one_in(ps+16)
          sleep temp/6
          improv_F
          sleep temp/6
        else
          sleep temp/3
        end
      end
    end
  end
  in_thread do
    d.times do
      drum
    end
  end
  in_thread do
    bassF = [:Fs2,:A2,:Cs2,:E2,:Fs3,:A3,:Cs3,:E3]
    b.times do
      use_synth :beep
      play bassF[i], attack:0, release:0.4, pan:bass_pan
      if i < 7
        i+=1
      else
        i=0
      end
      sleep temp
    end
  end
  sleep t
  play choose([:G3,:G4]), amp:0.75, pan:chord_pan
  play choose([:B3,:B4,:B5]), amp:0.75, pan:chord_pan
  play choose([:D3,:D4,:D5]), amp:0.75, pan:chord_pan
  play choose([:E4,:E5]), amp:0.75, pan:chord_pan
  in_thread do
    if one_in(acomp)
      use_synth :chiplead
      play choose([:G3,:G4,:B3,:B4,:B5,:D3,:D4,:D5,:E4,:E5]), attack:0, release:0.2, pan:synth_pan
      if one_in(acomp)
        sleep temp/3
        play choose([:G3,:G4,:B3,:B4,:B5,:D3,:D4,:D5,:E4,:E5]), attack:0, release:0.2, pan:synth_pan
      end
    end
    sleep 3*temp
    if one_in(acomp)
      play choose([:G3,:G4,:B3,:B4,:B5,:D3,:D4,:D5,:E4,:E5]), attack:0, release:0.2, pan:synth_pan
      if one_in(acomp)
        sleep temp/3
        play choose([:G3,:G4,:B3,:B4,:B5,:D3,:D4,:D5,:E4,:E5]), attack:0, release:0.2, pan:synth_pan
      end
    end
  end
  t = choose ([4*temp,6*temp,8*temp])
  n = t/(temp/3)
  d = n/6
  b = n/3
  in_thread do
    n.times do
      if one_in(ps)
        sleep temp/3
      else
        improv_G
        if one_in(ps+16)
          sleep temp/6
          improv_G
          sleep temp/6
        else
          sleep temp/3
        end
      end
    end
  end
  in_thread do
    d.times do
      drum
    end
  end
  in_thread do
    bassG = [:G2,:B2,:D2,:E2,:G3,:B3,:D3,:E3]
    b.times do
      use_synth :beep
      play bassG[i], attack:0, release:0.4, pan:bass_pan
      if i < 7
        i+=1
      else
        i=0
      end
      sleep temp
    end
  end
  sleep t
  ps +=2
  if acomp > 1
    acomp -=1
  end
end

run_file get(:rfpath)+"bass_solo.rb"
