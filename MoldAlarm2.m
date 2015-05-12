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

% Last Modified by GUIDE v2.5 11-May-2015 22:39:16

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



function FirstReferenceImage_Callback(hObject, eventdata, handles)
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



function SecondReferenceImage_Callback(hObject, eventdata, handles)
% hObject    handle to SecondReferenceImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SecondReferenceImage as text
%        str2double(get(hObject,'String')) returns contents of SecondReferenceImage as a double


% --- Executes during object creation, after setting all properties.
function SecondReferenceImage_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SecondReferenceImage (see GCBO)
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
