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


% �洢XML���ݵ��ַ���


% ��ȡ��Ӱ����
start_index = strfind(textInfo, '<title><![CDATA[') + length('<title><![CDATA[');
end_index = strfind(textInfo, ']]></title>') - 1;
title = textInfo(start_index:end_index);
disp(['Movie Title: ' title]);





% 
% rss = xmlread(java.io.StringBufferInputStream(textInfo.xml));
% 
% items = rss.getElementsByTagName('item');
% 
% % ѭ���������� item �ڵ㣬��ȡ��Ҫ����Ϣ
% for i = 0:items.getLength-1
%     % ��ȡ title
%     titleNode = items.item(i).getElementsByTagName('title').item(0);
%     title = char(titleNode.getTextContent);
% 
%     % ��ȡ���֡�Ƭ������Ƭ����/���������ݺ����ݵ���Ϣ
%     descNode = items.item(i).getElementsByTagName('description').item(0);
%     desc = char(descNode.getTextContent);
%     rating = regexp(desc, '���֣�([\d\.]+)', 'tokens', 'once');
%     length = regexp(desc, 'Ƭ����(\d+)����', 'tokens', 'once');
%     country = regexp(desc, '��Ƭ����\/������(.+)', 'tokens', 'once');
%     director = regexp(desc, '���ݣ�(.+)', 'tokens', 'once');
%     actors = regexp(desc, '���ݣ�(.+)', 'tokens', 'once');
%     
%     % ��ȡ��Ӱ����
%     linkNode = items.item(i).getElementsByTagName('link').item(0);
%     link = char(linkNode.getTextContent);
%     
%     % ������������ȡ������Ϣ
%     fprintf('%s\n���֣�%s\nƬ����%s����\n��Ƭ����/������%s\n���ݣ�%s\n���ݣ�%s\n���ӣ�%s\n\n', title, rating{1}, length{1}, country{1}, director{1}, actors{1}, link);
% end


else
    
    msg = 'Error occurred ,Pls check the Python Environment';
    error(msg);
    
    
end








