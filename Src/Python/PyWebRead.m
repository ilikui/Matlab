
%% matlab 准备python环境

[version, executable, isloaded] = pyversion;

if(isloaded)
    
    
    import py.requests.Request
    % py.importlib.import_module('requests')
    
else
    disp("Pls check the Python Env")
end



%  matlab 使用python环境

% 示例  https://xiaoapi.cn/API/lt_xiaoai.php?type=json&msg=你会什么？

BaseHttp = "https://xiaoapi.cn/API/lt_xiaoai.php?type=json&msg=";

x = " ";


while x ~=  "End"
    prompt ="Pls ask me?   \n";

    x = input(prompt,"s");
    
    
    RequestHttp =BaseHttp+x;
    Response = py.requests.get(RequestHttp);


    Mdata  =  jsondecode(string(Response.text));

    
    
    [returnAudio,returnFs] = webread(Mdata.data.tts,weboptions('ContentType','audio','Timeout',60));

    sound(returnAudio,returnFs)
end
 



%% 数据测试


