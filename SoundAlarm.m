function SoundAlarm()

    %set frequency and sampling rate
    frequency = 600;
    sampling_rate = 44100;
    
    %larger values for hold period produce longer beeps
    holdPeriod = 1; 
    time = 0:1/sampling_rate:holdPeriod;     
    
    %calculates the sound wave
    output_signal = sin(2*pi*frequency*time);
    
    %creates the audioplayer object to play the sound
    output_audio = audioplayer(output_signal,sampling_rate); 

    %plays sound
    for x = 1:3
        playblocking(output_audio);
        pause(.5)
    end

end