
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
%     Response = py.requests.get(RequestHttp);
% 
% 
%    
% 
%     
%     
%     [returnAudio,returnFs] = webread(Mdata.url,weboptions('ContentType','audio','Timeout',60));
% 
%     sound(returnAudio,returnFs)

 



%% 数据测试


