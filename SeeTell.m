function varargout = SeeTell(varargin)
% SEETELL MATLAB code for SeeTell.fig
%      SEETELL, by itself, creates a new SEETELL or raises the existing
%      singleton*.
%
%      H = SEETELL returns the handle to a new SEETELL or the handle to
%      the existing singleton*.
%
%      SEETELL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SEETELL.M with the given input arguments.
%
%      SEETELL('Property','Value',...) creates a new SEETELL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SeeTell_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SeeTell_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SeeTell

% Last Modified by GUIDE v2.5 13-Apr-2017 14:44:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SeeTell_OpeningFcn, ...
                   'gui_OutputFcn',  @SeeTell_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before SeeTell is made visible.
function SeeTell_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SeeTell (see VARARGIN)

% Choose default command line output for SeeTell
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SeeTell wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% Adding Background Image
mainAxes = axes('units','normalized', ...
          'position',[0 0 1 1]);
uistack(mainAxes,'bottom');
I = imread('background.png');
hi = imagesc(I);
colormap gray
set(mainAxes,'handlevisibility','off', ...
    'visible','off');

% Creating Panels
createGettingStartedContainer;
createCameraContainer;
createUploadImageContainer;
createUploadPdfContainer;
createFinalContainer;

% GETTING STARTED UI--------------------
function createGettingStartedContainer
global StartingContainer
StartingContainer = uipanel('Title','Getting Started','FontSize',10,'FontName','Comic Sans MS',...
             'BackgroundColor','[0.83, 0.82, 0.78]',...
             'Position',[.25 .15 .60 .70]);
tbox = uicontrol(StartingContainer,'style','text','FontSize',16,'FontName','Comic Sans MS',...
         'BackgroundColor','[0.83, 0.82, 0.78]',...
         'string','Welcome !!',...
         'Units','normalized',...
         'Position',[.20 .15 .60 .70]);
tbox1 = uicontrol(StartingContainer,'style','text','FontSize',14,'FontName','Comic Sans MS',...
         'BackgroundColor','[0.83, 0.82, 0.78]',...
         'string','To get started click on any of the buttons on your left..',...
         'Units','normalized',...
         'Position',[.20 .05 .60 .70]);

StartingContainer.Visible = 'on';
% GETTING STARTED UI ENDS--------------------

% CAPTURE IMAGE UI--------------------
function createCameraContainer
global cameraContainer
cameraContainer = uipanel('Title','Capture Image',...
         'FontSize',10,'FontName', 'Comic Sans MS',...
         'BackgroundColor','[0.83, 0.82, 0.78]',...
         'Position',[.25 .15 .60 .70]);
tbox = uicontrol(cameraContainer,'style','text','FontSize',16,'FontName','Comic Sans MS',...
         'BackgroundColor','[0.83, 0.82, 0.78]',...
         'string','Accessing Camera',...
         'Units','normalized',...
         'Position',[.20 .15 .60 .70]);
tbox1 = uicontrol(cameraContainer,'style','text','FontSize',14,'FontName','Comic Sans MS',...
         'BackgroundColor','[0.83, 0.82, 0.78]',...
         'string','Please keep your document ready...',...
         'Units','normalized',...
         'Position',[.20 .05 .60 .70]);
button = uicontrol(cameraContainer,'Style','pushbutton','String','Next',...
         'FontSize',12,'FontName','Comic Sans MS',...
         'BackgroundColor','white',...
         'Units','normalized',...
         'Position',[.40 .20 .20 .10],...
         'Callback', @nextButtonCameraCallback);
global errorCamera
errorCamera = uicontrol(cameraContainer,'style','text',...
         'FontSize',10,'FontName','Comic Sans MS',...
         'BackgroundColor','[0.83, 0.82, 0.78]', 'ForegroundColor', 'red',...
         'string','',...
         'Units','normalized',...
         'Position',[.35 .10 .30 .06]);
cameraContainer.Visible = 'off';

function nextButtonCameraCallback(source, event)
global errorCamera
global finalContainer
global cameraContainer
global textSentences
if(exist('testframe.jpg', 'file'))
    set(errorCamera, 'String', '');
    try
        textdetection;
        set(textSentences, 'String', '');
        cameraContainer.Visible = 'off';
        finalContainer.Visible = 'on';
    catch ME
        set(errorCamera, 'String', 'Text cannot be extracted! Retry!');
    end
else
    set(errorCamera, 'String', 'Please capture an image!');
end
% CAPTURE IMAGE UI ENDS--------------------

% UPLOAD IMAGE UI--------------------
function createUploadImageContainer
global uploadImageContainer
uploadImageContainer = uipanel('Title','Upload Image',...
         'FontSize',10,'FontName', 'Comic Sans MS',...
         'BackgroundColor','[0.83, 0.82, 0.78]',...
         'Position',[.25 .15 .60 .70]);

tbox = uicontrol(uploadImageContainer,'style','text',...
         'FontSize',14,'FontName','Comic Sans MS',...
         'BackgroundColor','[0.83, 0.82, 0.78]',...
         'string','Enter complete file name of image file',...
         'Units','normalized',...
         'Position',[.20 .65 .60 .20]);

global edit
edit = uicontrol(uploadImageContainer, 'Style','edit',...
         'FontSize',12,'FontName','Comic Sans MS',...
         'Units','normalized',...
         'Position',[.17 .63 .50 .10]);

button = uicontrol(uploadImageContainer,'Style','pushbutton','String','Browse',...
         'FontSize',12,'FontName','Comic Sans MS',...
         'BackgroundColor','white',...
         'Units','normalized',...
         'Position',[.70 .63 .15 .10],...
         'Callback', @browseButtonImage);

global error
error = uicontrol(uploadImageContainer,'style','text',...
         'FontSize',10,'FontName','Comic Sans MS',...
         'BackgroundColor','[0.83, 0.82, 0.78]', 'ForegroundColor', 'red',...
         'string','',...
         'Units','normalized',...
         'Position',[.25 .53 .35 .06]);


next = uicontrol(uploadImageContainer,'Style','pushbutton','String','Next',...
         'FontSize',12,'FontName','Comic Sans MS',...
         'BackgroundColor','white',...
         'Units','normalized',...
         'Position',[.40 .20 .20 .10],...
         'Callback', @nextButtonImage);
     uploadImageContainer.Visible = 'off';

function browseButtonImage(source, event)
[filename, pathname] = ...
     uigetfile({'*.bmp';'*.gif';'*.png';'*.jpeg';'*.jpg'},'File Selector');
 
 global file 
 file = filename;
 global path
 path = pathname;
 
 global edit
 global error
 set(edit, 'String', strcat(pathname,filename));
 set(error, 'String', '');
 
 function nextButtonImage(source, event)
 global edit
 global error
 S = get(edit, 'String');
 if isempty(S)    
    set(error, 'String', 'Please enter a path for file to be uploaded');
 else
    if (~exist(S, 'file'))
        set(error, 'String', 'File does not exist');
    else
        set(error, 'String', '');
        global file
        global path
        dots = strfind(file, '.');
        lastDot = dots(length(dots));
        extention = file(lastDot:end);
        finalFilename = strcat('testframe', extention);
        copyfile(strcat(path,file), finalFilename);
    
        selectedImage = imread(finalFilename);
        ocrResults = ocr(selectedImage);
        recognizedText = ocrResults.Text;
        fid = fopen('Text.txt','wt');
        fprintf(fid, recognizedText);
        fclose(fid);
    end
 end  
 set(edit, 'String','');
 global textSentences
 set(textSentences, 'String', '');
 global uploadImageContainer
 uploadImageContainer.Visible = 'off';
 global finalContainer
 finalContainer.Visible = 'on';
 % UPLOAD IMAGE UI ENDS--------------------

 % UPLOAD PDF UI--------------------
 function createUploadPdfContainer
global uploadPdfContainer
uploadPdfContainer = uipanel('Title','Upload PDF',...
         'FontSize',10,'FontName', 'Comic Sans MS',...
         'BackgroundColor','[0.83, 0.82, 0.78]',...
         'Position',[.25 .15 .60 .70]);

tbox = uicontrol(uploadPdfContainer,'style','text',...
         'FontSize',14,'FontName','Comic Sans MS',...
         'BackgroundColor','[0.83, 0.82, 0.78]',...
         'string','Enter complete file name of PDF file',...
         'Units','normalized',...
         'Position',[.20 .65 .60 .20]);

global editPDF
editPDF = uicontrol(uploadPdfContainer, 'Style','edit',...
         'FontSize',12,'FontName','Comic Sans MS',...
         'Units','normalized',...
         'Position',[.17 .63 .50 .10]);

button = uicontrol(uploadPdfContainer,'Style','pushbutton','String','Browse',...
         'FontSize',12,'FontName','Comic Sans MS',...
         'BackgroundColor','white',...
         'Units','normalized',...
         'Position',[.70 .63 .15 .10],...
         'Callback', @browseButtonPDF);

global errorPDF
errorPDF = uicontrol(uploadPdfContainer,'style','text',...
         'FontSize',10,'FontName','Comic Sans MS',...
         'BackgroundColor','[0.83, 0.82, 0.78]', 'ForegroundColor', 'red',...
         'string','',...
         'Units','normalized',...
         'Position',[.25 .53 .35 .08]);


next = uicontrol(uploadPdfContainer,'Style','pushbutton','String','Next',...
         'FontSize',12,'FontName','Comic Sans MS',...
         'BackgroundColor','white',...
         'Units','normalized',...
         'Position',[.40 .20 .20 .10],...
         'Callback', @nextButtonPDF);
     uploadPdfContainer.Visible = 'off';
     
function browseButtonPDF(source, event)
[filename, pathname] = ...
     uigetfile({'*.pdf'},'File Selector');
 
 global filePDF 
 filePDF = filename;
 global pathPDF
 pathPDF = pathname;
 
 global editPDF
 global errorPDF
 set(editPDF, 'String', strcat(pathname,filename));
 set(errorPDF, 'String', '');
 
 function nextButtonPDF(source, event)
 global editPDF
 global errorPDF
 S = get(editPDF, 'String');
 if isempty(S)    
    set(errorPDF, 'String', 'Please enter a path for the PDF file to be uploaded');
 else
    if (~exist(S, 'file'))
        set(errorPDF, 'String', 'File does not exist');
    else
        set(errorPDF, 'String', '');
    global filePDF
    global pathPDF
    dots = strfind(filePDF, '.');
    lastDot = dots(length(dots));
    extention = filePDF(lastDot:end);
    finalFilename = strcat('testframe', extention);
    copyfile(strcat(pathPDF,filePDF), finalFilename);
    
    javaaddpath('PDFBox-0.7.3.jar')
    pdfdoc = org.pdfbox.pdmodel.PDDocument;
    reader = org.pdfbox.util.PDFTextStripper;
    pdfdoc = pdfdoc.load(finalFilename);
    pdfdoc.isEncrypted
    pdfstr = reader.getText(pdfdoc); 
    class(pdfstr);
    pdfstr = char(pdfstr);
    class(pdfstr);
    pdfstr = deblank(pdfstr);
    fid = fopen('Text.txt','wt');
    fprintf(fid, pdfstr);
    fclose(fid);
    end
 end
 set(editPDF, 'String','');
 global textSentences
 set(textSentences, 'String', '');
 global uploadPdfContainer
 uploadPdfContainer.Visible = 'off';
 global finalContainer
 finalContainer.Visible = 'on';
% UPLOAD PDF UI ENDS--------------------

% SPEECH UI--------------------
function createFinalContainer
 global finalContainer
 finalContainer = uipanel('Title','Speech',...
         'FontSize',10,'FontName', 'Comic Sans MS',...
         'BackgroundColor','[0.83, 0.82, 0.78]',...
         'Position',[.25 .10 .60 .80]);
 global index
 index = 1;

 global oldstate
 oldstate = -1;

 global speed 
 speed = -10;

 listOfVoices = strsplit(tts('', 'List'), '%%','CollapseDelimiters',true);

 global voice
 voice = listOfVoices(1);

 button = uicontrol(finalContainer,'Style','pushbutton','String','Save As',...
         'FontSize',12,'FontName','Comic Sans MS',...
         'BackgroundColor','white',...
         'Units','normalized',...
         'Position',[.05 .85 .15 .07],...
         'Callback', @saveasCallback);
  
 tboxVoice = uicontrol(finalContainer,'style','text',...
         'FontSize',10,'FontName','Comic Sans MS',...
         'BackgroundColor','[0.83, 0.82, 0.78]',...
         'string','Voice',...
         'Units','normalized',...
         'Position',[.38 .88 .10 .10]);
 global listVoice
 listVoice = uicontrol(finalContainer,'Style', 'listbox',...
           'String', listOfVoices,...
           'FontSize',11,'FontName','Comic Sans MS',...
           'BackgroundColor','white',...
           'Units','normalized',...
           'Position', [.23 .72 .40 .20],...
           'Callback', @voiceCallback);
   
 tboxSpeed = uicontrol(finalContainer,'style','text',...
         'FontSize',10,'FontName','Comic Sans MS',...
         'BackgroundColor','[0.83, 0.82, 0.78]',...
         'string','Speed',...
         'Units','normalized',...
         'Position',[.74 .88 .10 .10]);
 global listSpeed
 listSpeed = uicontrol(finalContainer,'Style', 'listbox',...
           'String', {'-10', '-9','-8','-7','-6','-5','-4','-3','-2','-1','0','1','2','3','4','5','6','7','8','9','10' },...
           'FontSize',11,'FontName','Comic Sans MS',...
           'BackgroundColor','white',...
           'Units','normalized',...
           'Position', [.66 .72 .28 .20],...
           'Callback', @speedCallback);
       
 global search
 search = uicontrol(finalContainer, 'Style','edit',...
         'FontSize',11,'FontName','Comic Sans MS',...
         'Units','normalized',...
         'Position',[.20 .60 .40 .07]);
 global buttonSearch
 buttonSearch = uicontrol(finalContainer,'Style','pushbutton','String','Search',...
         'FontSize',12,'FontName','Comic Sans MS',...
         'BackgroundColor','white',...
         'Units','normalized',...
         'Position',[.61 .60 .15 .07],...
         'Callback', @searchCallback);
  global searchResult
  searchResult = uicontrol(finalContainer, 'Style', 'text',...
            'FontSize',10,'FontName','Comic Sans MS',...
            'BackgroundColor','[0.83, 0.82, 0.78]',...
            'string','',...
            'Units','normalized',...
            'Position',[.25 .52 .30 .07]);
        
 global textSentences
 textSentences = uicontrol(finalContainer,'style','text',...
         'FontSize',12,'FontName','Comic Sans MS',...
         'BackgroundColor','white',...
         'string','',...
         'Units','normalized',...
         'Position',[.05 .05 .70 .45]);
 global buttonPlayPause
 buttonPlayPause = uicontrol(finalContainer,'Style','pushbutton','String','Play',...
         'FontSize',12,'FontName','Comic Sans MS',...
         'BackgroundColor','white',...
         'Units','normalized',...
         'Position',[.80 .32 .15 .10],...
         'Callback', @playPauseCallback);
     
 buttonStop = uicontrol(finalContainer,'Style','pushbutton','String','Stop',...
         'FontSize',12,'FontName','Comic Sans MS',...
         'BackgroundColor','white',...
         'Units','normalized',...
         'Position',[.80 .13 .15 .10],...
         'Callback', @stopCallback);
  
 finalContainer.Visible = 'off';
 
function stopCallback(source, event)
global index
global sentences
global textSentences
index = length(sentences) + 1;
set(textSentences, 'String', '');

function playPauseCallback(source, event)
global sentences
global index
global speed
global voice
global oldstate
global buttonPlayPause
global buttonSearch
global textSentences

if strcmp(get(buttonPlayPause,'String'),'Play')
    % Read Text.txt and form sentenses  
    if exist('Text.txt', 'file')
        text = fileread('Text.txt');
        lastChar = text(length(text));
        if (~(strcmp(lastChar, '.') || strcmp(lastChar, '!') || strcmp(lastChar,'?')))
            text = strcat(text, '.');
        end
     else
        text = ' ';
     end
    sentences = regexp(text,'\S.*?[\.\!\?]','match');
    
    set(buttonPlayPause,'String','Pause');
    set(buttonSearch, 'Enable', 'off');
    if(oldstate > -1)
        index = oldstate;
    end
    while(length(sentences) >= index)
        set(textSentences, 'String', sentences(index));
        sentence = cell2str(sentences(index));
        pause(0.5);
        tts(sentence, voice, speed);
        index = index + 1;
    end
    set(buttonPlayPause,'String','Play');
    set(buttonSearch, 'Enable', 'on');
    index = 1;
else
    oldstate = index + 1;
    index = length(sentences);
end      
 
 function searchCallback(source, event)
 global search
 global searchResult
 userInput = get(search, 'String');
 [status,synonyms] = dictionary(userInput);
 synonymString = '';
 if (status == 1)
    for i = 1:length(synonyms) - 1
        synonymString = strcat(synonymString, synonyms(i));
        synonymString = strcat(synonymString, ' -- ');
    end
    synonymString = strcat(synonymString, synonyms(length(synonyms)));
    set(searchResult, 'string',synonymString);
 else
    set(searchResult, 'string',synonyms);
 end        
 
function speedCallback(source, event)
global listSpeed
index_selected = get(listSpeed,'Value');
list = get(listSpeed,'String');
item_selected = list{index_selected};
global speed
speed = str2double(item_selected);
 
function voiceCallback(source, event)
global listVoice
index_selected = get(listVoice,'Value');
list = get(listVoice,'String');
global voice
voice = list{index_selected};  

function saveasCallback
[filename, pathname] = uiputfile({'*.txt'},'Save as');
str = fileread('Text.txt');
finalname=strcat(pathname, '/', filename);
fid = fopen(finalname,'wt');
fprintf(fid, str);
fclose(fid);
% SPEECH UI ENDS--------------------


% --- Outputs from this function are returned to the command line.
function varargout = SeeTell_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in CaptureImage.
function CaptureImage_Callback(hObject, eventdata, handles)
% hObject    handle to CaptureImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global StartingContainer
global cameraContainer
global uploadImageContainer
global uploadPdfContainer
global finalContainer
StartingContainer.Visible = 'off';
uploadImageContainer.Visible = 'off';
uploadPdfContainer.Visible = 'off';
finalContainer.Visible = 'off';
cameraContainer.Visible = 'on';

global errorCamera
set(errorCamera, 'String', '');
CameraGUI;

% --- Executes on button press in UploadImage.
function UploadImage_Callback(hObject, eventdata, handles)
% hObject    handle to UploadImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global StartingContainer
global cameraContainer
global uploadImageContainer
global uploadPdfContainer
global finalContainer
StartingContainer.Visible = 'off';
cameraContainer.Visible = 'off';
uploadPdfContainer.Visible = 'off';
finalContainer.Visible = 'off';
uploadImageContainer.Visible = 'on';


% --- Executes on button press in UploadPDF.
function UploadPDF_Callback(hObject, eventdata, handles)
% hObject    handle to UploadPDF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global StartingContainer
global cameraContainer
global uploadImageContainer
global uploadPdfContainer
global finalContainer
StartingContainer.Visible = 'off';
cameraContainer.Visible = 'off';
uploadImageContainer.Visible = 'off';
finalContainer.Visible = 'off';
uploadPdfContainer.Visible = 'on';
