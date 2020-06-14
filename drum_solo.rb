temp = 0.4
intensity = 10

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

define :fill_hit do |intensity|
  ch = [:drum_snare_soft,:drum_snare_hard,:drum_tom_hi_soft,:drum_tom_mid_soft,:drum_cymbal_closed]
  if one_in(intensity)
    sample choose(ch), amp:0.75
  end
end

define :fill_hit_accent do |intensity|
  ch1 = [:drum_snare_soft,:drum_tom_hi_hard,:drum_tom_mid_hard,:drum_cymbal_open,:drum_snare_hard]
  if one_in(intensity)
    sample choose(ch1)
  end
end

define :ghost do |intensity|
  ch2 = [:drum_snare_soft,:drum_cymbal_closed]
  if one_in(intensity+2)
    sample choose(ch2), amp:0.5
  end
end

define :drum_solo do |intensity|
  sample :drum_heavy_kick
  fill_hit_accent intensity
  sleep 0.25*temp
  ghost intensity
  sleep 0.25*temp
  fill_hit intensity
  sleep 0.25*temp
  ghost intensity
  sleep 0.25*temp
  fill_hit intensity
  sleep 0.25*temp
  ghost intensity
  sleep 0.25*temp
  fill_hit intensity
  sleep 0.25*temp
  ghost intensity
  sleep 0.25*temp
  if one_in(2)
    sample :drum_heavy_kick
  else
    sample :drum_cymbal_soft
  end
  fill_hit_accent intensity
  sleep 0.25*temp
  ghost intensity
  sleep 0.25*temp
  fill_hit intensity
  sleep 0.25*temp
  ghost intensity
  sleep 0.25*temp
  fill_hit intensity
  sleep 0.25*temp
  ghost intensity
  sleep 0.25*temp
  fill_hit intensity
  sleep 0.25*temp
  ghost intensity
  sleep 0.25*temp
end

define :bass_solo do |chord|
  use_synth :beep
  8.times do
    if one_in(3)
      sleep 0.5*temp
    else
      play choose(chord), attack:0, release:0.4, pan:bass_pan
      sleep 0.5*temp
    end
  end
end

define :bass_comp do |chord|
  use_synth :beep
  play chord[0], attack:0, release:0.4, pan:bass_pan
  sleep 4*temp
  if one_in(2)
    play choose(chord), attack:0, release:0.4, pan:bass_pan
  end
  sleep 4*temp
end

define :bass_comp_2 do |chord|
  use_synth :beep
  play chord[0], attack:0, release:0.4, pan:bass_pan
  sleep 4*temp
end

define :bridge do |intensity, temp|
  use_synth :fm
  play Emaj7, amp:3, attack:0, release:0.4, pan:chord_pan
  in_thread do
    bass_comp bass_Emaj7
  end
  in_thread do
    2.times do
      drum_solo intensity
    end
  end
  intensity -= 3
  sleep 8*temp
  play Gsmin7, amp:3, attack:0, release:0.4, pan:chord_pan
  in_thread do
    bass_comp bass_Gsmin7
  end
  in_thread do
    2.times do
      drum_solo intensity
    end
  end
  intensity -= 3
  sleep 8*temp
  play Amaj7, amp:3, attack:0, release:0.4, pan:chord_pan
  in_thread do
    bass_comp bass_Amaj7
  end
  in_thread do
    2.times do
      drum_solo intensity
    end
  end
  intensity -= 3
  sleep 8*temp
  play Amin7, amp:3, attack:0, release:0.4, pan:chord_pan
  in_thread do
    bass_comp bass_Amin7
  end
  in_thread do
    2.times do
      drum_solo intensity
    end
  end
  sleep 8*temp
  play Gmaj7, amp:3, attack:0, release:0.4, pan:chord_pan
  in_thread do
    bass_solo bass_Gmaj7
  end
  sleep 4*temp
  play D13, amp:3, attack:0, release:0.4, pan:chord_pan
  in_thread do
    bass_comp_2 bass_D13
  end
  in_thread do
    drum_solo intensity
  end
  sleep 4*temp
  play Bmins9, amp:3, attack:0, release:0.4, pan:chord_pan
  in_thread do
    bass_solo bass_Bmins9
  end
  sleep 4*temp
  play Amin7, amp:3, attack:0, release:0.4, pan:chord_pan
  in_thread do
    bass_comp_2 bass_Amin7
  end
  in_thread do
    drum_solo intensity
  end
  sleep 4*temp
  play Gsmin7, amp:3, attack:0, release:0.4, pan:chord_pan
  in_thread do
    2.times do
      drum_solo intensity
    end
  end
  sleep 8*temp
  play B7, amp:3, attack:0, release:0.4, pan:chord_pan
  in_thread do
    2.times do
      drum_solo intensity
    end
  end
  sleep 8*temp
end


bridge intensity, temp

run_file get(:rfpath)+"improv_1.rb"
