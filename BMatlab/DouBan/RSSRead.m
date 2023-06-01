url = 'http://rsshub.baitry.com/douban/movie/playing';


import java.io.StringBufferInputStream


[v, e, isloaded] = pyversion;


if (isloaded) 
py.importlib.import_module('requests')

httpCode = py.requests.get(url);
% 
textInfo = string(httpCode.text);


end




doc = xmlread(java.io.StringBufferInputStream(textInfo));

% ��ȡ��Ӱ����
title_el = doc.getElementsByTagName('title').item(0);
title = char(title_el.getFirstChild().getData());

% ��ȡ��Ӱ���֡�Ƭ������Ƭ����/���������ݡ����ݺͺ���ͼƬ���ӵ���Ϣ
description_el = doc.getElementsByTagName('description').item(0);
description = char(description_el.getFirstChild().getData());

rating = strsplit(description, '���֣�');
rating = rating{2}(1:end-6);

runtime = strsplit(description, 'Ƭ����');
runtime = runtime{2}(1:end-6);

country = strsplit(description, '��Ƭ����/������');
country = country{2}(1:end-6);

director = strsplit(description, '���ݣ�');
director = director{2}(1:end-6);

cast = strsplit(description, '���ݣ�');
cast = cast{2}(1:end-6);

image_url = strsplit(description, '<img src="');
image_url = image_url{2}(1:strfind(image_url{2},'"')-1);

% �����ȡ����Ϣ
fprintf('Title: %s\n', title);
fprintf('Rating: %s\n', rating);
fprintf('Runtime: %s\n', runtime);
fprintf('Country: %s\n', country);
fprintf('Director: %s\n', director);
fprintf('Cast: %s\n', cast);
fprintf('Image URL: %s\n', image_url);




% ����XML
%xml = xmlread(textInfo);

% % ����ÿ����Ӱ��Ŀ����ȡ��Ϣ
% items = xml.getElementsByTagName('item');
% for i=0:items.getLength()-1
%     item = items.item(i);
%     title = char(item.getElementsByTagName('title').item(0).getTextContent().strip()); % ����
%     rating = char(strsplit(char(item.getElementsByTagName('description').item(0).getTextContent())){2}(3:end)); % ����
%     runtime = char(strsplit(char(item.getElementsByTagName('description').item(0).getTextContent())){3}(3:end)); % Ƭ��
%     country = char(strsplit(char(item.getElementsByTagName('description').item(0).getTextContent())){4}(3:end)); % ��Ƭ����/����
%     director = char(strsplit(char(item.getElementsByTagName('description').item(0).getTextContent())){5}(3:end)); % ����
%     cast = char(strsplit(char(item.getElementsByTagName('description').item(0).getTextContent())){6}(3:end)); % ����
%     image_url = char(strsplit(char(item.getElementsByTagName('description').item(0).getTextContent())){7}(11:end-2)); % ����ͼƬ����
% 
%     % �����ȡ����Ϣ
%     fprintf('Title: %s\n', title);
%     fprintf('Rating: %s\n', rating);
%     fprintf('Runtime: %s\n', runtime);
%     fprintf('Country: %s\n', country);
%     fprintf('Director: %s\n', director);
%     fprintf('Cast: %s\n', cast);
%     fprintf('Image URL: %s\n', image_url);
%     fprintf('---\n');
% end