function [status,varargout] = dictionary(text)

%DICTIONARY checks the spelling status of word(s) and returns synonyms if found.
%
% [status,synonyms] = dictionary(text);
% status = dictionary(text);
% 
%     text:         word(s) separated by a single space.
%     status:       returns '1' if word(s) exist in dictionary or '0' otherwise.
%     synonyms:     an array of synonyms of word(s) or otherwise returns
%                   a message 'No Synonyms Found!' or 'Incorrect Spelling!'.
% 
% Examples:
%      [status,synonyms] = dictionary('peddler');
%      [status,synonyms] = dictionary('walk match ground');
%      status = dictionary('hysteria');


% Separating string of words into arrays of words.
k=1;
temp='';
for n=1:length(text);
    if ~isspace(text(n))
        temp = [temp text(n)];
    else
        if ~isspace(text(n-1))
            words{k} = temp;
        end
        temp='';
        k=k+1;
    end
end
words{k} = temp;

% Opening MS Word and Starting the Spelling Check & Finding Synonyms

Doc = actxserver('Word.Application');
m=1;
for n=1:length(words)
    if ~isempty(words{n})
        status(m) = invoke(Doc,'CheckSpelling',words{n},[],1,1);
        if nargout==2
            X = invoke(Doc,'SynonymInfo',words{n});
            Synonyms = get(X,'MeaningList');
            Meanings{m,1} = words{n};
            if length(Synonyms)==0 & status(m)==1
                Meanings{m,2} = 'No Synonyms Found!';
            elseif status(m)==0
                Meanings{m,2} = 'Incorrect Spelling!';
            else
                for k=2:length(Synonyms)+1
                    Meanings{m,k} = Synonyms{k-1};
                end
            end
        end
        m=m+1;
    end
end

if exist('Meanings','var')
    varargout = {Meanings};
end
status = all(status);

invoke(Doc,'Quit');
delete(Doc);