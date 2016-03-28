function varargout = GUI_V2p2(varargin)
% GUI_V2p2 MATLAB code for GUI_V2p2.fig
%      GUI_V2p2, by itself, creates a new GUI_V2p2 or raises the existing
%      singleton*.
%
%      H = GUI_V2p2 returns the handle to a new GUI_V2p2 or the handle to
%      the existing singleton*.
%
%      GUI_V2p2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_V2p2.M with the given input arguments.
%
%      GUI_V2p2('Property','Value',...) creates a new GUI_V2p2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_V2p2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_V2p2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_V2p2

% Last Modified by GUIDE v2.5 20-Mar-2013 13:35:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_V2p2_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_V2p2_OutputFcn, ...
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


% --- Executes just before GUI_V2p2 is made visible.
function GUI_V2p2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_V2p2 (see VARARGIN)

% Choose default command line output for GUI_V2p2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_V2p2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_V2p2_OutputFcn(hObject, eventdata, handles) 
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
filename=uigetfile({'*.jpg';'*.tif';'*.*'}, 'Select image file');
picture=imread(filename);
imagesc(picture);
colormap Gray
valeurmoy=mean(mean(picture));


handles.filename=filename;
handles.picture=picture;
handles.valeurmoy=valeurmoy;

set(handles.edit2,'String', filename)

guidata(hObject, handles);

%%%%%%%%%%%%%%%% Square sublattice 1 %%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in pushbutton3. 
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_state=get(hObject,'Value');
Data = handles.picture;
valeurmoy=handles.valeurmoy;
sx=handles.sx;

n=0;
sublatt1=[0 0];
[B,A]=size(Data);
updatedata=Data; %nouvelle natrice qui servira a afficher les pixels morts
v = caxis; %trouve cmin et cmax, les store dans v pour pouvoir les reutiliser lors du reploting

while button_state == get(hObject, 'Max')
    n=n+1;
    k=waitforbuttonpress;
    pixel=round(get(gca,'CurrentPoint'));
    X=pixel(1,1);
    Y=pixel(1,2);
   if X < 0 || Y < 0  || X > A || Y > B
   break
   set(hObject, 'Min');
   end
   sublatt1(n,1)=X
   sublatt1(n,2)=Y
   value=Data(Y,X)
   if value > valeurmoy
       sublatt1(n,3)=sx(1,1);
       sublatt1(n,4)=sx(1,2);
   elseif value < valeurmoy
       sublatt1(n,3)=-sx(1,1);
       sublatt1(n,4)=-sx(1,2);
   else
       continue
   end
   updatedata(Y-1:Y+1,X-1:X+1)=0; %marque les iles
   imagesc(updatedata)
   caxis (v)
end

imagesc(Data) % affiche a nouveau la figure complete
handles.sublatt1 = sublatt1;
% handles.updatedata = updatedata;
guidata(hObject, handles);

%%%%%%%%%%%%%%%% Square sublattice 2 %%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in pushbutton4. 
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_state=get(hObject,'Value');
Data = handles.picture;
valeurmoy=handles.valeurmoy;
sy=handles.sy;

n=0;
sublatt2=[0 0];
[B,A]=size(Data);
updatedata=Data; %nouvelle natrice qui servira a afficher les pixels morts
v = caxis; %trouve cmin et cmax, les store dans v pour pouvoir les reutiliser lors du reploting

while button_state == get(hObject, 'Max')
    n=n+1;
    k=waitforbuttonpress;
    pixel=round(get(gca,'CurrentPoint'));
    X=pixel(1,1);
    Y=pixel(1,2);
   if X < 0 || Y < 0  || X > A || Y > B
   break
   set(hObject, 'Min');
   end
   sublatt2(n,1)=X
   sublatt2(n,2)=Y
   value=Data(Y,X)
   if value > valeurmoy
       sublatt2(n,3)=-sy(1,1);
       sublatt2(n,4)=sy(1,2);
   elseif value < valeurmoy
       sublatt2(n,3)=sy(1,1);
       sublatt2(n,4)=-sy(1,2);
   else
       continue
   end
   updatedata(Y-1:Y+1,X-1:X+1)=0; %marque les iles
   imagesc(updatedata)
   caxis (v)
end

imagesc(Data) % affiche a nouveau la figure complete
handles.sublatt2 = sublatt2;  

guidata(hObject, handles);

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sublatt1=handles.sublatt1;
sublatt2=handles.sublatt2;
sx=handles.sx;
sy=handles.sy;

coordintensity=[sx(1,1) sx(1,2) 0 0;sy(1,1) sy(1,2) 0 0;sublatt1;sublatt2];

% save data.dat coordintensity -ascii
% [filename,pathname] = uiputfile('data.dat', 'Save the data as'); %ouvre le dialogue de sauvegarde
% fullname = fullfile(pathname,filename);
% dlmwrite(fullname, coordintensity, 'delimiter', ' ');

coordintensity(1:2,:)=[];
handles.coordintensity=coordintensity; %cree un handle pour passer les data

% uisave
dlmwrite('coordintensity.dat', coordintensity, 'delimiter', ' ');
        
guidata(hObject, handles);

%%%%%% Distance and correlation between islands
% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

data=handles.coordintensity;
minvalue=handles.minvalue;
n=size(data,1);
corrNN=0;
corrL=0;
corrT=0;
m=0;
p=0;
q=0;

for a=1:n-1
    for b=a+1:n
        distance=sqrt(((data(a,1)-data(b,1))^2)+(data(a,2)-data(b,2))^2)
        poue=minvalue
        %calcul du vecteur position r12 = distance entre spin 1 et spin 2
        if distance <= minvalue %toutes les distances inscrites dans le cercle de rayon minvalue
            scalprospin=(data(a,3)*data(b,3))+(data(a,4)*data(b,4)); %produit scalaire des spins des iles
           if scalprospin == 0 % si les spins sont perpendiculaires, ils sont les plus proches voisins
            m=m+1;
            sp1=((data(b,1)-data(a,1))*data(a,3))+((data(b,2)-data(a,2))*data(a,4)); %calcul du produit scalaire  r12.S1
            sp2=((data(b,1)-data(a,1))*data(b,3))+((data(b,2)-data(a,2))*data(b,4)); %calcul du produit scalaire r12.S2
            corrNN=corrNN-sign(sp1*sp2);
           else
               sp=((data(b,1)-data(a,1))*data(a,3))+((data(b,2)-data(a,2))*data(a,4)) %produit scalaire entre le vecteur position et le spin de l ile consideree
            if abs(sp) > 31 % les iles sont voisines lateralement
                p=p+1;
                sp3=((data(a,3)*data(b,3))+(data(a,4)*data(b,4)))
                corrL=corrL+sign(sp3);
            else
                q=q+1; %les iles sont voisines transversalement
                sp4=((data(a,3)*data(b,3))+(data(a,4)*data(b,4)))
                corrT=corrT+sign(sp4);
            end
           end
        else
            continue
        end
    end
end

correlationNN=corrNN/m
correlationL=corrL/p
correlationT=corrT/q
% save correlation.dat correlation -ascii

corrtable=[correlationNN;correlationL;correlationT];
dlmwrite('Correlationtable.dat', corrtable, 'delimiter', ' ');

% handles.correlation=correlation;
set(handles.edit1,'String',num2str(correlationNN))
set(handles.edit5,'String',num2str(correlationL))
set(handles.edit6,'String',num2str(correlationT))
guidata(hObject, handles);

%%%%%%%%%%% Distance minimale entre deux pixels %%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

m=0;

for a=1:2
    m=m+1;
    k=waitforbuttonpress;
    pixel=round(get(gca,'CurrentPoint'));
    point(m,1)=pixel(1,1);
    point(m,2)=pixel(1,2);
end

minvalue=sqrt((point(1,1)-point(2,1))^2+(point(1,2)-point(2,2))^2); %distance between two neighbouring islands
dlmwrite('minvalue.dat',minvalue,'delimiter',' ');
handles.minvalue=minvalue;
guidata(hObject, handles);



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%%%%%%%%%%%%%%%%%%% Enregistre la valeur de l angle%%%%%%%%%%%%%%%%%%%%%%%
function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double
angle=str2double(get(hObject,'String')); %prend la valeur de l angle
% angle entre l horizontale et le sous reseau 1
sx(1,1)=cosd(angle);
sx(1,2)=sind(angle);

sy(1,1)=sind(angle);
sy(1,2)=cosd(angle);

handles.sx=sx;
handles.sy=sy;

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
