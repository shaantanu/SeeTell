function wav = tts(txt,voice,pace)
%TTS text to speech.
%   TTS (TXT) synthesizes speech from string TXT, and speaks it. The audio
%   format is mono, 16 bit, 16k Hz by default.
%   
%   WAV = TTS(TXT, 'List') vocalize and output to the variable WAV.
%
%   TTS(TXT,VOICE) uses the specific voice. Use TTS('','List') to see a
%   list of availble voices. Default is the first voice.
%
%   TTS(...,PACE) set the pace of speech to PACE. PACE ranges from 
%   -10 (slowest) to 10 (fastest). Default 0.
%   
%   This function requires the Microsoft Win32 Speech API (SAPI).
%
%   Examples:
%       % Speak the text;
%       tts('I can speak.');
%       % List availble voices;
%       tts('I can speak.','List');
%       % Speak out and store the voices in a variable;
%       w = tts('I can speak.','List');

if ~ispc, error('Microsoft Win32 SAPI is required.'); end
if ~ischar(txt), error('First input must be string.'); end

SV = actxserver('SAPI.SpVoice');
TK = invoke(SV,'GetVoices');

if nargin > 1
    % Select voice;
    wav = '';
    for k = 0:TK.Count-1
        if strcmpi(voice,TK.Item(k).GetDescription)
            SV.Voice = TK.Item(k);
            break;
        elseif strcmpi(voice,'list')
            wav = strcat(wav,(TK.Item(k).GetDescription));
            wav = strcat(wav, '%%');
        end
    end
    wav = wav(1:length(wav)-2);
    % Set pace;
    if nargin > 2
        if isempty(pace), pace = 0; end
        if abs(pace) > 10, pace = sign(pace)*10; end        
        SV.Rate = pace;
    end
end

invoke(SV,'Speak',txt);

delete(SV); 
clear SV TK;
pause(0.2);

end % TTS;