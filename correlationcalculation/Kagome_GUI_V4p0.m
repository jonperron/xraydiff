function varargout = Kagome_GUI_V2p(varargin)
% Kagome_GUI_V2p MATLAB code for Kagome_GUI_V2p.fig
%      Kagome_GUI_V2p, by itself, creates a new Kagome_GUI_V2p or raises the existing
%      singleton*.
%
%      H = Kagome_GUI_V2p returns the handle to a new Kagome_GUI_V2p or the handle to
%      the existing singleton*.
%
%      Kagome_GUI_V2p('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in Kagome_GUI_V2p.M with the given input arguments.
%
%      Kagome_GUI_V2p('Property','Value',...) creates a new Kagome_GUI_V2p or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Kagome_GUI_V2p_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Kagome_GUI_V2p_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Kagome_GUI_V2p

% Last Modified by GUIDE v2.5 20-Nov-2013 15:59:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Kagome_GUI_V2p_OpeningFcn, ...
                   'gui_OutputFcn',  @Kagome_GUI_V2p_OutputFcn, ...
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


% --- Executes just before Kagome_GUI_V2p is made visible.
function Kagome_GUI_V2p_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Kagome_GUI_V2p (see VARARGIN)

% Choose default command line output for Kagome_GUI_V2p
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Kagome_GUI_V2p wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Kagome_GUI_V2p_OutputFcn(hObject, eventdata, handles) 
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

%%%%%%%%%%%%%%%% Kagome sublattice 1 %%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in pushbutton3. 
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_state=get(hObject,'Value');
Data = handles.picture;
valeurmoy=handles.valeurmoy;
s1=handles.s1;

n=0;
sublatt1=[0 0 0 0];
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
   %coord(n,3)=Data(X,Y)
   sublatt1(n,1)=X
   sublatt1(n,2)=Y
   value=Data(Y,X)
   if value > valeurmoy
       sublatt1(n,3)=s1(1,1);
       sublatt1(n,4)=s1(1,2);
   elseif value < valeurmoy
       sublatt1(n,3)=s1(2,1);
       sublatt1(n,4)=s1(2,2);
   else
       continue
   end
   updatedata(Y-1:Y+1,X-1:X+1)=0; %marque les iles
   imagesc(updatedata)
   caxis (v)
end

imagesc(Data) % affiche a nouveau la figure complete
handles.sublatt1 = sublatt1;
% dlmwrite('coordintensity.dat', coordintensity, 'delimiter', ' ');  

guidata(hObject, handles);

%%%%%%%%%%%%%%%% Kagome sublattice 2 %%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in pushbutton4. 
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_state=get(hObject,'Value');
Data = handles.picture;
valeurmoy=handles.valeurmoy;
s2=handles.s2;

n=0;
sublatt2=[0 0 0 0];
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
       sublatt2(n,3)=s2(1,1);
       sublatt2(n,4)=s2(1,2);
   elseif value < valeurmoy
       sublatt2(n,3)=s2(2,1);
       sublatt2(n,4)=s2(2,2);
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

%%%%%%%%%%%%%%%% Kagome sublattice 3 %%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_state=get(hObject,'Value');
Data = handles.picture;
valeurmoy=handles.valeurmoy;
s3=handles.s3;

n=0;
sublatt3=[0 0 0 0];
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
   sublatt3(n,1)=X;
   sublatt3(n,2)=Y
   value=Data(Y,X)
   if value > valeurmoy
       sublatt3(n,3)=s3(1,1);
       sublatt3(n,4)=s3(1,2);
   elseif value < valeurmoy
       sublatt3(n,3)=s3(2,1);
       sublatt3(n,4)=s3(2,2);
   else
       continue
   end
   updatedata(Y-1:Y+1,X-1:X+1)=0; %marque les iles
   imagesc(updatedata)
   caxis (v)
end

imagesc(Data) % affiche a nouveau la figure complete
handles.sublatt3 = sublatt3;
% dlmwrite('coordintensity.dat', coordintensity, 'delimiter', ' ');  

guidata(hObject, handles);

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sublatt1=handles.sublatt1;
sublatt2=handles.sublatt2;
sublatt3=handles.sublatt3;
s1=handles.s1;
s2=handles.s2;
s3=handles.s3;
coordintensity=[s1(1,1) s1(1,2) 0 0;s2(1,1) s2(1,2) 0 0;s3(1,1) s3(1,2) 0 0;sublatt1;sublatt2;sublatt3];

clear sublatt1 sublatt2 sublatt3

% [filename,pathname] = uiputfile('data.dat', 'Save the data as'); %ouvre le dialogue de sauvegarde
% fullname = fullfile(pathname,filename);
dlmwrite('coordintensity.dat', coordintensity, 'delimiter', ' ');
coordintensity(1:3,:)=[];

handles.coordintensity=coordintensity;

guidata(hObject, handles);

%%%%%% Distance and correlation between islands
%%%% Greek letters corresponds to what is used by Rougemaille et al, PRL 106, 057209 (2011) 
% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

data=handles.coordintensity;
minvalue=handles.minvalue;
n=size(data);
%%% Variables initialization
corrBETA = 0;
corrGAMMA = 0;
corrMU = 0;
m=0;
p=0;
q=0;
%  Experimental - modify if necessary - added 2013/08/15
corrDELTA = 0;
corrTAU = 0;
r=0;
s=0;

for a=1:n-1
    for b=a+1:n
        distance=sqrt(((data(a,1)-data(b,1))^2)+((data(a,2)-data(b,2))^2));   
        if distance <minvalue
            spina=sqrt((data(a,3)^2+data(a,4)^2));
            spinb=sqrt((data(b,3)^2+data(b,4)^2));
            spab=((data(a,3)*data(b,3))+(data(a,4)*data(b,4)));
            phi= acosd(spab/(spina*spinb));
            if phi == 0 || phi == 180
                m=m+1;
                corrMU=corrMU+sign(spab);
            else
               if distance < minvalue/2
                p=p+1;
                corrBETA=corrBETA+sign(spab);
               elseif distance > minvalue/2
                q=q+1;
                corrGAMMA=corrGAMMA-sign(spab);
               else
                   continue
               end
            end
%  Experimental - modify if necessary - added 2013/08/15
        elseif distance >= minvalue && distance < 1.55*minvalue %5 percent variation due to distortion of the picture
            spina=sqrt((data(a,3)^2+data(a,4)^2));
            spinb=sqrt((data(b,3)^2+data(b,4)^2));
            spab=((data(a,3)*data(b,3))+(data(a,4)*data(b,4)));
            phi= acosd(spab/(spina*spinb));
            if distance >= minvalue && distance < 1.1*minvalue
                if phi == 0 || phi == 180
                    r=r+1;
                    corrDELTA=corrDELTA-sign(spab);
                else
                    continue
                end
            elseif distance < 1.55*minvalue
                s=s+1;
                corrTAU=corrTAU+sign(spab);
            else
                continue
            end                
        else
            continue
        end
    end
end
               
           
correlationbeta=corrBETA/p
correlationgamma=corrGAMMA/q
correlationmu=corrMU/m
correlationdelta=corrDELTA/r
correlationtau=corrTAU/s
% save correlation.dat correlation -ascii
%%% Construction of a table with corrGREEK as first column, romanletter as
%%% second column and correlationgreek as third column and save
%%% modified 2013/08/15

corrtablecolumnA=[corrBETA;corrGAMMA;corrMU;corrDELTA;corrTAU];
corrtablecolumnB=[p;q;m;r;s];
corrtablecolumnC=[correlationbeta;correlationgamma;correlationmu;correlationdelta;correlationtau];
% corrtable=[correlationbeta;correlationgamma;correlationmu];
corrtable=[corrtablecolumnA corrtablecolumnB corrtablecolumnC];
dlmwrite('Correlationtable.dat', corrtable, 'delimiter', ' ');

% handles.correlation=correlation;
set(handles.edit1,'String',num2str(correlationbeta))
set(handles.edit4,'String',num2str(correlationgamma))
set(handles.edit5,'String',num2str(correlationmu))
set(handles.edit7,'String',num2str(correlationdelta))
set(handles.edit8,'String',num2str(correlationtau))
guidata(hObject, handles);

%%%%%%%%%%% Lattice parameters definition %%%%%%%%%%%%%%%%%%%%%%%%%%%
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

minvalue=sqrt((point(1,1)-point(2,1))^2+(point(1,2)-point(2,2))^2);

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



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


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
angle=str2double(get(hObject,'String')); %prend la valeur de l angle

% ile 1
s1(1,1)=cosd(angle);
s1(1,2)=-sind(angle);
s1(2,1)=-cosd(angle);
s1(2,2)=sind(angle);

% ile 2
s2(1,1)=(0.5*cosd(angle))-(0.8660*sind(angle));
s2(1,2)=-(0.5*sind(angle))-(0.8660*cosd(angle));
s2(2,1)=-(0.5*cosd(angle))+(0.8660*sind(angle));
s2(2,2)=(0.5*sind(angle))+(0.8660*cosd(angle));

%ile 3
s3(1,1)=(0.5*cosd(angle))+(0.8660*sind(angle));
s3(1,2)=-(0.5*sind(angle))+(0.8660*cosd(angle));
s3(2,1)=-(0.5*cosd(angle))-(0.8660*sind(angle));
s3(2,2)=(0.5*sind(angle))-(0.8660*cosd(angle));

% % ile 1
% s1(1,1)=-sind(angle);
% s1(1,2)=cosd(angle);
% s1(2,1)=sind(angle);
% s1(2,2)=-cosd(angle);
% 
% % ile 2
% s2(1,1)=((cosd(angle))/2)-((sqrt(3)/2)*sind(angle));
% s2(1,2)=((sind(angle))/2)+((sqrt(3)/2)*cosd(angle));
% s2(2,1)=((cosd(angle))/2)+((sqrt(3)/2)*sind(angle));
% s2(2,2)=((sind(angle))/2)-((sqrt(3)/2)*cosd(angle));
% 
% %ile 3
% s3(1,1)=-((cosd(angle))/2)-((sqrt(3)/2)*sind(angle));
% s3(1,2)=-((sind(angle))/2)+((sqrt(3)/2)*cosd(angle));
% s3(2,1)=-((cosd(angle))/2)+((sqrt(3)/2)*sind(angle));
% s3(2,2)=-((sind(angle))/2)-((sqrt(3)/2)*cosd(angle));

handles.s1=s1;
handles.s2=s2;
handles.s3=s3;

guidata(hObject, handles);

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



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
