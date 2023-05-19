httpBase = "https://rsshub.baitry.com/douban/movie/playing";



[v, e, isloaded] = pyversion;


if (isloaded) 
py.importlib.import_module('requests')

% py.importlib.import_module('xml.etree.ElementTree') 
% 
% 
% 
% response = py.requests.get(httpBase);
% data = response.content;
% 
% 
% root = py.xml.etree.ElementTree.fromstring(data);
% 
% disp(root)

httpCode = py.requests.get(httpBase);
% 
textInfo = string(httpCode.text);


% 存储XML内容的字符串


% 提取电影标题
start_index = strfind(textInfo, '<title><![CDATA[') + length('<title><![CDATA[');
end_index = strfind(textInfo, ']]></title>') - 1;
title = textInfo(start_index:end_index);
disp(['Movie Title: ' title]);





% 
% rss = xmlread(java.io.StringBufferInputStream(textInfo.xml));
% 
% items = rss.getElementsByTagName('item');
% 
% % 循环遍历所有 item 节点，提取需要的信息
% for i = 0:items.getLength-1
%     % 获取 title
%     titleNode = items.item(i).getElementsByTagName('title').item(0);
%     title = char(titleNode.getTextContent);
% 
%     % 获取评分、片长、制片国家/地区、导演和主演等信息
%     descNode = items.item(i).getElementsByTagName('description').item(0);
%     desc = char(descNode.getTextContent);
%     rating = regexp(desc, '评分：([\d\.]+)', 'tokens', 'once');
%     length = regexp(desc, '片长：(\d+)分钟', 'tokens', 'once');
%     country = regexp(desc, '制片国家\/地区：(.+)', 'tokens', 'once');
%     director = regexp(desc, '导演：(.+)', 'tokens', 'once');
%     actors = regexp(desc, '主演：(.+)', 'tokens', 'once');
%     
%     % 获取电影链接
%     linkNode = items.item(i).getElementsByTagName('link').item(0);
%     link = char(linkNode.getTextContent);
%     
%     % 在命令窗口输出提取到的信息
%     fprintf('%s\n评分：%s\n片长：%s分钟\n制片国家/地区：%s\n导演：%s\n主演：%s\n链接：%s\n\n', title, rating{1}, length{1}, country{1}, director{1}, actors{1}, link);
% end


else
    
    msg = 'Error occurred ,Pls check the Python Environment';
    error(msg);
    
    
end








