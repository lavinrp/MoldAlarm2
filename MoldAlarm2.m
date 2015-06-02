function varargout = MoldAlarm2(varargin)
% MOLDALARM2 MATLAB code for MoldAlarm2.fig
%      MOLDALARM2, by itself, creates a new MOLDALARM2 or raises the existing
%      singleton*.
%
%      H = MOLDALARM2 returns the handle to a new MOLDALARM2 or the handle to
%      the existing singleton*.
%
%      MOLDALARM2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MOLDALARM2.M with the given input arguments.
%
%      MOLDALARM2('Property','Value',...) creates a new MOLDALARM2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MoldAlarm2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MoldAlarm2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MoldAlarm2

% Last Modified by GUIDE v2.5 13-May-2015 01:59:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MoldAlarm2_OpeningFcn, ...
                   'gui_OutputFcn',  @MoldAlarm2_OutputFcn, ...
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


% --- Executes just before MoldAlarm2 is made visible.
function MoldAlarm2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MoldAlarm2 (see VARARGIN)

% Choose default command line output for MoldAlarm2
handles.output = hObject;

%!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
%stores the filepath of the images
handles.filePath = '';


%^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MoldAlarm2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MoldAlarm2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function FilePath_Callback(hObject, eventdata, handles)
% hObject    handle to FilePath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
%read in the given string and save to handles.filePath
filePath = get(hObject,'String');
%TODO: print error if issue


%if the filepath is valid save it and enable thte FirstReferenceImage box
if isdir(filePath)
    handles.filePath = filePath;
    set(handles.FirstReferenceImage, 'Enable', 'on');
    set(handles.Start, 'Enable', 'on');
    set(handles.StartingImage, 'Enable', 'on');
end

% Update handles structure
guidata(hObject, handles);

%^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

% Hints: get(hObject,'String') returns contents of FilePath as text
%        str2double(get(hObject,'String')) returns contents of FilePath as a double


% --- Executes during object creation, after setting all properties.
function FilePath_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FilePath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Start.
function Start_Callback(hObject, eventdata, handles)
% hObject    handle to Start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
 
%find axes;
 axes1 = handles.axes1;

%get reference to tif Files;
 filePath = get(handles.FilePath, 'String');
 tifFiles = dir(strcat(filePath,'/*.tif')); 

 %get referenceImage and rectangle for future cropping(cropRect)
 refImageNum = uint8(str2double(get(handles.FirstReferenceImage,'String')));  
 [referenceImage, cropRect] = GetReferenceImage(filePath, refImageNum, tifFiles);
 imshow(referenceImage);
 
 %image to start checking for mold at
 lastCheckedFrame = uint8(str2double(get(handles.StartingImage,'String')));
 
 %every 40 seconds check to see if there is an unchecked frame
 mold = false;
 
 %while mold has not been found check frames for mold
 while ~mold
     %if there are files that have not been checked
     if lastCheckedFrame < length(tifFiles)
         %aquire the cropped image to check for mold
         imageToCheck = GetImage(filePath, tifFiles(lastCheckedFrame + 1), cropRect);

         %check the frame for mold
         mold = CheckFrameForMold(imageToCheck, referenceImage);
         lastCheckedFrame = lastCheckedFrame + 1;
         
     %wait 40 seconds only if there are no unchecked frames
     else
         pause(40);         
     end
     

 end
 
 
 %mold found if here
 SoundAlarm();
 %update starting image to lastCheckedFrame in case of false positive
 set(handles.StartingImage, 'String', num2str(lastCheckedFrame));
 % Update handles structure
 guidata(hObject, handles);
 


 
 %TODO if there is an unchecked frame check for mold

%^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^



function FirstReferenceImage_Callback(hObject, eventdata, handles, axes1)
% hObject    handle to FirstReferenceImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FirstReferenceImage as text
%        str2double(get(hObject,'String')) returns contents of FirstReferenceImage as a double


% --- Executes during object creation, after setting all properties.
function FirstReferenceImage_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FirstReferenceImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function StartingImage_Callback(hObject, eventdata, handles)
% hObject    handle to StartingImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of StartingImage as text
%        str2double(get(hObject,'String')) returns contents of StartingImage as a double


% --- Executes during object creation, after setting all properties.
function StartingImage_CreateFcn(hObject, eventdata, handles)
% hObject    handle to StartingImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Continue.
function Continue_Callback(hObject, eventdata, handles)
% hObject    handle to Continue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Close.
function Close_Callback(hObject, eventdata, handles)
% hObject    handle to Close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%quit program
clear all;
close all;
quit;
