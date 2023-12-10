function varargout = DouYin(varargin)
% DOUYIN MATLAB code for DouYin.fig
%      DOUYIN, by itself, creates a new DOUYIN or raises the existing
%      singleton*.
%
%      H = DOUYIN returns the handle to a new DOUYIN or the handle to
%      the existing singleton*.
%
%      DOUYIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DOUYIN.M with the given input arguments.
%
%      DOUYIN('Property','Value',...) creates a new DOUYIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DouYin_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DouYin_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DouYin

% Last Modified by GUIDE v2.5 05-Jun-2023 20:39:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DouYin_OpeningFcn, ...
                   'gui_OutputFcn',  @DouYin_OutputFcn, ...
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


% --- Executes just before DouYin is made visible.
function DouYin_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DouYin (see VARARGIN)

% Choose default command line output for DouYin
handles.output = hObject;

set(handles.pushbutton1,'String','Ë¢ÐÂ');
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DouYin wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = DouYin_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp("Hello world");
