function varargout = DeathClock_GUI(varargin)
% DEATHCLOCK_GUI MATLAB code for DeathClock_GUI.fig
%      DEATHCLOCK_GUI, by itself, creates a new DEATHCLOCK_GUI or raises the existing
%      singleton*.
%
%      H = DEATHCLOCK_GUI returns the handle to a new DEATHCLOCK_GUI or the handle to
%      the existing singleton*.
%
%      DEATHCLOCK_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DEATHCLOCK_GUI.M with the given input arguments.
%
%      DEATHCLOCK_GUI('Property','Value',...) creates a new DEATHCLOCK_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DeathClock_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DeathClock_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DeathClock_GUI

% Last Modified by GUIDE v2.5 02-Dec-2014 15:49:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DeathClock_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @DeathClock_GUI_OutputFcn, ...
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

% --- Executes just before DeathClock_GUI is made visible.
function DeathClock_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DeathClock_GUI (see VARARGIN)

% Choose default command line output for DeathClock_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DeathClock_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = DeathClock_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



%% --- Executes on button press in Calculate.
function Calculate_Callback(hObject, eventdata, handles)
% hObject    handle to Calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% Process Tables
TABLES = struct();
tables = struct();
TABLES.DIR = strcat(mfilename('fullpath'),'\csv\');
TABLES.files = dir(strcat(TABLES.DIR,'*.csv'));
TABLES.files = {TABLES.files.name};
disp(strcat('retrieving tables from ', TABLES.DIR));
        disp('Loading files...');
        types = TABLES.files;
        for i = 1:numel(types)
            disp(strcat(num2str(i),'/',num2str(numel(types)),' files loaded'));
            if ~(strcmp(types{i},'age')||strcmp(types{i},'ethnic')||strcmp(types{i},'gender'))% We don't have or need tables for these
                if exist(strcat(TABLES.DIR,types{i}),'file')% If the table exists load it, else show error
                    disp(strcat('Loading \',TABLES.DIR,types{i},'\ ...'));     
                    tables.(strrep(types{i},'.csv','')) = csvread(strcat(TABLES.DIR,types{i}),1,1); 
                else
                    disp(strcat('Sorry but \',TABLES.DIR,types{i},'\ does not exists'));
                end
            end
        end
        
%% Process Age
contentsage = get(handles.Age,'String'); 
age_value = str2double(contentsage{get(handles.Age,'Value')});

%% Process Ethnicity
% 0 = White, 1 =  lack, 2= asian
 contents = get(handles.ethnic,'String'); 
 ethnic = contents{get(handles.ethnic,'Value')};
 switch ethnic
     case 'White'
         ethnic_value = 0;
     case 'Black'
         ethnic_value = 1;
     case 'Asian'
         ethnic_value = 2;
 end

%% Process Gender
contents = get(handles.gender,'String'); 
gender = contents{get(handles.gender,'Value')};
 switch gender
     case 'Male'
         gender_value = 0;
     case 'Female'
         gender_value = 1;
 end
 
%% Process Pregnancy
contents = get(handles.pregnancy,'String'); 
pregnancy = contents{get(handles.pregnancy,'Value')};
switch pregnancy
     case 'No/Not female'
         pregnancy_value = 0;
     case 'Yes'
         pregnancy_value= 1;
 end
 

%% Process Driving
contents = get(handles.driving,'String'); 
driving = contents{get(handles.driving,'Value')};
 switch driving
     case 'Yes'
         driving_value = 1;
     case 'No'
         driving_value = 0;
 end
 
%% Process Asthma
contents = get(handles.asthma,'String'); 
asthma = contents{get(handles.asthma,'Value')};
 switch asthma
     case 'Yes'
         asthma_value = 1;
     case 'No'
         asthma_value = 0;
 end
 
%% Process Smoking 
h_selectedRadioButton = get(handles.smoking,'SelectedObject');
selectedRadioTag = get(h_selectedRadioButton,'tag');
switch selectedRadioTag
   case 'rarelysmoke'
        smoking_value = 0;
   case 'sometimessmoke'
        smoking_value = 1;
   case 'oftensmoke'
        smoking_value = 2; 
end

%% Process Drinking
h_selectedRadioButton = get(handles.drinking,'SelectedObject');
selectedRadioTag = get(h_selectedRadioButton,'tag');
switch selectedRadioTag
   case 'rarelydrink'
        drinking_value = 0;
   case 'sometimesdrink'
        drinking_value = 1;
   case 'oftendrink'
        drinking_value = 2; 
end

%% Process Swimming
h_selectedRadioButton = get(handles.swim,'SelectedObject');
selectedRadioTag = get(h_selectedRadioButton,'tag');
switch selectedRadioTag
   case 'rarelyswim'
        swimming_value = 0;
   case 'sometimesswim'
        swimming_value = 1;
   case 'oftenswim'
        swimming_value = 2; 
end

%% Process Travel
h_selectedRadioButton = get(handles.travel,'SelectedObject');
selectedRadioTag = get(h_selectedRadioButton,'tag');
switch selectedRadioTag
   case 'rarelytravel'
        travel_value = 0;
   case 'sometimestravel'
        travel_value = 1;
   case 'oftentravel'
        travel_value = 2; 
end

%% Process Cleaning
h_selectedRadioButton = get(handles.clean,'SelectedObject');
selectedRadioTag = get(h_selectedRadioButton,'tag');
switch selectedRadioTag
   case 'rarelyclean'
        clean_value = 0;
   case 'sometimesclean'
        clean_value = 1;
   case 'oftenclean'
        clean_value = 2; 
end
%% Unprocessed
premium_value = 100%Starting premium
intrest_value = 0.10%Given Intrest rate (should this be default?)
nurishment_value = 0;%Do you keep a healthy diet Y/N
drugs_value = 0;%Do you take part in recrectional drugs Y/N
diabetes_value = 0;%Do you have diabetes Y/N

%% Run Compute Life Function 
PARAMS.general = 1;
PARAMS.age = age_value;
PARAMS.nurishment = nurishment_value;
PARAMS.drugs = drugs_value;
PARAMS.diabetes = diabetes_value;
PARAMS.premium = premium_value;
PARAMS.intrest = intrest_value;
PARAMS.ethnic = ethnic_value;
PARAMS.gender = gender_value;
PARAMS.preg = pregnancy_value; 
PARAMS.drive = driving_value; 
PARAMS.asthma = asthma_value;
PARAMS.smoking = smoking_value;
PARAMS.alcohol = drinking_value; 
PARAMS.swim = swimming_value;
PARAMS.travel = travel_value;
PARAMS.poison = clean_value;
disp(PARAMS);
computedlife = computelife(tables,PARAMS);

%Plot Prob. to Die
scatter(handles.dying_axes,[1,4:5:100,100],1-computedlife.table.px)

%Plot Prob. to Survive
scatter(handles.surviving_axes,[1,4:5:100,100],computedlife.table.px)

%Plot No. of People Alive
scatter(handles.peoplealive_axes,[1,4:5:100,100],computedlife.table.lx)

%Plot No. of People Died
scatter(handles.peopledead_axes,[1,4:5:100,100],computedlife.table.dx)

%Results
set(handles.deathoutput,'String', computedlife.expected_age); %display expected age
set(handles.payoutoutput,'String',computedlife.expected_return); %display expected output

% --- Executes on selection change in Age.
function Age_Callback(hObject, eventdata, handles)
% hObject    handle to Age (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Age contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Age
 
% --- Executes during object creation, after setting all properties.
function Age_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Age (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ethnic.
function ethnic_Callback(hObject, eventdata, handles)
% hObject    handle to ethnic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ethnic contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ethnic

% --- Executes during object creation, after setting all properties.
function ethnic_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ethnic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in gender.
function gender_Callback(hObject, eventdata, handles)
% hObject    handle to gender (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns gender contents as cell array
%        contents{get(hObject,'Value')} returns selected item from gender


% --- Executes during object creation, after setting all properties.
function gender_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gender (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in driving.
function driving_Callback(hObject, eventdata, handles)
% hObject    handle to driving (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns driving contents as cell array
%        contents{get(hObject,'Value')} returns selected item from driving


% --- Executes during object creation, after setting all properties.
function driving_CreateFcn(hObject, eventdata, handles)
% hObject    handle to driving (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in asthma.
function asthma_Callback(hObject, eventdata, handles)
% hObject    handle to asthma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns asthma contents as cell array
%        contents{get(hObject,'Value')} returns selected item from asthma


% --- Executes during object creation, after setting all properties.
function asthma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to asthma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pregnancy.
function pregnancy_Callback(hObject, eventdata, handles)
% hObject    handle to pregnancy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pregnancy contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pregnancy


% --- Executes during object creation, after setting all properties.
function pregnancy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pregnancy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function deathoutput_Callback(hObject, eventdata, handles)
% hObject    handle to deathoutput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of deathoutput as text
%        str2double(get(hObject,'String')) returns contents of deathoutput as a double
set(handles.deathoutput, 'String', 'hi');

% --- Executes during object creation, after setting all properties.
function deathoutput_CreateFcn(hObject, eventdata, handles)
% hObject    handle to deathoutput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function payoutoutput_Callback(hObject, eventdata, handles)
% hObject    handle to payoutoutput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of payoutoutput as text
%        str2double(get(hObject,'String')) returns contents of payoutoutput as a double


% --- Executes during object creation, after setting all properties.
function payoutoutput_CreateFcn(hObject, eventdata, handles)
% hObject    handle to payoutoutput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when selected object is changed in smoking.
function smoking_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in smoking 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on mouse press over axes background.
function dying_axes_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to dying_axes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when selected object is changed in clean.
function clean_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in clean 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)



function premium_Callback(hObject, eventdata, handles)
% hObject    handle to premium (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of premium as text
%        str2double(get(hObject,'String')) returns contents of premium as a double


% --- Executes during object creation, after setting all properties.
function premium_CreateFcn(hObject, eventdata, handles)
% hObject    handle to premium (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
