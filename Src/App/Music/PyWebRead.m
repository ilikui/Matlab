
%% matlab 准备python环境

[version, executable, isloaded] = pyversion;

if(isloaded)
    
    
    import py.requests.Request
    % py.importlib.import_module('requests')
    
else
    disp("Pls check the Python Env")
end



%  matlab 使用python环境

% 示例  https://xiaoapi.cn/API/yy_sq.php?msg=梦想家童声版&type=json&n=1

BaseHttp = " https://xiaoapi.cn/API/yy_sq.php?msg=";

TailHttp = "&type=json&n=1";

Msg = "梦想家童声版";



validHttp =strcat(BaseHttp,Msg,TailHttp);
Response = py.requests.get(validHttp);

Mdata  =  jsondecode(string(Response.text));


    
%     RequestHttp =BaseHttp+x;

%Response = py.requests.get(RequestHttp);
% 
% 
%    
% 
%     
%     
    [returnAudio,returnFs] = webread(Mdata.url,weboptions('ContentType','audio','Timeout',60));

    % sound(returnAudio,returnFs)
    
    
    %% settings
div = 0.2;
y = returnAudio;

Fs = returnFs;
%% read file

T = 1/Fs;
L = length(y)-mod(length(y),2);
t = (0:L-1)*T;
l = div*Fs;

%% HPF
Hlp = btw;
y1 = filtfilt(Hlp.sosMatrix, 1, y);

%% play music
sound(y,Fs);

%% FFT
for i=1:L/(l-1)
    t1 = clock;
    x = y1(i*l:(i+1)*l);
    FFT(x,l,Fs);
    t2 = etime(clock,t1);
    pause(div-t2);
end

function [] = FFT(x,l,Fs)
Y = fft(x);
P2 = abs(Y/l);
P1 = P2(1:l/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(l/2))/l;
plot(f,P1);
%axis([1e3 1.8e4 0 0.15]);
end

 



%% 数据测试


