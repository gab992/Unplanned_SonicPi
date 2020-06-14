temp = 0.4
intensity = 12

piano_pan = 0.5
synth_pan = -0.5
bass_pan = 0.25
chord_pan = -0.25

Emaj7 = [:E2,:B2,:Ds4,:Gs5]
Gsmin7 = [:Gs2,:Ds3,:Fs4,:B5]
Amaj7 = [:A2,:E3,:Gs5,:Cs6]
Amin7 = [:A2,:E3,:G5,:C6]
Gmaj7 =[:G2,:D3,:As4,:B5]
D13 = [:D2,:C3,:Fs4,:B5]
Bmins9 = [:B2,:D3,:A4,:D6]
B7 = [:B3,:Fs4,:A5,:Ds6]

bass_Emaj7 = [:E2,:Gs2,:B2,:Ds2,:E3,:Gs3,:B3,:Ds3]
bass_Gsmin7 = [:Gs2,:Ds2,:Fs2,:B2,:Gs3,:Ds3,:Fs3,:B3]
bass_Amaj7 = [:A2,:E2,:Gs2,:Cs2,:A3,:E3,:Gs3,:Cs3]
bass_Amin7 = [:A2,:E2,:G2,:C2,:A3,:E3,:G3,:C3]
bass_Gmaj7 = [:G2,:D2,:As2,:B2,:G3,:D3,:As3,:B3]
bass_D13 = [:D2,:C2,:Fs2,:B2,:D3,:C3,:Fs3,:B3]
bass_Bmins9 = [:B2,:D2,:A2,:D2,:B3,:D3,:A3,:D3]
bass_B7 = [:B2,:Fs2,:A2,:Ds2,:B3,:Fs3,:A3,:Ds3]

define :drum_comp_helper do
  3.times do
    if one_in(2)
      if one_in(2)
        sample :drum_snare_soft, amp:0.3
        if one_in(2)
          in_thread do
            sample :drum_cymbal_soft
            sleep temp/2
            sample :drum_cymbal_closed
          end
        end
        sleep temp/4
        sample :drum_snare_soft, amp:0.4
        sleep temp/4
      else
        sample :drum_snare_soft, amp:0.5
        if one_in(2)
          sample :drum_cymbal_closed
        end
        sleep temp/2
      end
      sample :drum_snare_soft, amp:0.75
      sleep temp/2
    else
      sample :drum_snare_soft
      sample :drum_heavy_kick
      sleep temp
    end
  end
end

define :drum_comp do
  i=0
  while i<8 do
    if one_in(4)
      drum_comp_helper
      i += 3
    else
      sleep temp
      i += 1
    end
  end
end

define :drum_comp_2 do
  if one_in(2)
    drum_comp_helper
    sleep temp
  else
    sleep temp
    drum_comp_helper
  end
end

define :bass_solo do |chord, intensity|
  use_synth :beep
  amps = [0.5,1,1.5,2]
  4.times do
    if one_in(intensity)
      play choose(chord), amp:choose(amps), attack:0, release:0.4, pan:bass_pan
      if one_in(intensity+5)
        sleep 0.25*temp
        play choose(chord), amp:choose(amps), attack:0, release:0.4, pan:bass_pan
        sleep 0.25*temp
      else
        sleep 0.5*temp
      end
    else
      if one_in(intensity+5)
        sleep 0.25*temp
        play choose(chord), amp:choose(amps), attack:0, release:0.4, pan:bass_pan
        sleep 0.25*temp
      else
        sleep 0.5*temp
      end
    end
  end
end

define :bridge do |intensity, temp|
  use_synth :fm
  play Emaj7, amp:3, attack:0, release:0.4, pan:chord_pan
  in_thread do
    drum_comp
  end
  in_thread do
    4.times do
      bass_solo bass_Emaj7, intensity
    end
  end
  intensity -= 3
  sleep 8*temp
  play Gsmin7, amp:3, attack:0, release:0.4, pan:chord_pan
  in_thread do
    drum_comp
  end
  in_thread do
    4.times do
      bass_solo bass_Gsmin7, intensity
    end
  end
  intensity -= 3
  sleep 8*temp
  play Amaj7, amp:3, attack:0, release:0.4, pan:chord_pan
  in_thread do
    drum_comp
  end
  in_thread do
    4.times do
      bass_solo bass_Amaj7, intensity
    end
  end
  intensity -= 3
  sleep 8*temp
  play Amin7, amp:3, attack:0, release:0.4, pan:chord_pan
  in_thread do
    drum_comp
  end
  in_thread do
    4.times do
      bass_solo bass_Amin7, intensity
    end
  end
  sleep 8*temp
  play Gmaj7, amp:3, attack:0, release:0.4, pan:chord_pan
  in_thread do
    drum_comp_2
  end
  in_thread do
    2.times do
      bass_solo bass_Gmaj7, intensity
    end
  end
  sleep 4*temp
  play D13, amp:3, attack:0, release:0.4, pan:chord_pan
  in_thread do
    drum_comp_2
  end
  in_thread do
    2.times do
      bass_solo bass_D13, intensity
    end
  end
  sleep 4*temp
  play Bmins9, amp:3, attack:0, release:0.4, pan:chord_pan
  in_thread do
    drum_comp_2
  end
  in_thread do
    2.times do
      bass_solo bass_Bmins9, intensity
    end
  end
  sleep 4*temp
  play Amin7, amp:3, attack:0, release:0.4, pan:chord_pan
  in_thread do
    drum_comp_2
  end
  in_thread do
    2.times do
      bass_solo bass_Amin7, intensity
    end
  end
  sleep 4*temp
  play Gsmin7, amp:3, attack:0, release:0.4, pan:chord_pan
  intensity -= 2
  in_thread do
    drum_comp
  end
  in_thread do
    4.times do
      bass_solo Gsmin7, intensity
    end
  end
  sleep 8*temp
  play B7, amp:3, attack:0, release:0.4, pan:chord_pan
  in_thread do
    4.times do
      drum
    end
  end
  in_thread do
    4.times do
      bass_solo bass_B7, intensity
    end
  end
  sleep 8*temp
end

sample :drum_cymbal_open
bridge intensity, temp

run_file get(:rfpath)+"improv_2.rb"
