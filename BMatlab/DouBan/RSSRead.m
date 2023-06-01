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

% 提取电影标题
title_el = doc.getElementsByTagName('title').item(0);
title = char(title_el.getFirstChild().getData());

% 提取电影评分、片长、制片国家/地区、导演、主演和海报图片链接等信息
description_el = doc.getElementsByTagName('description').item(0);
description = char(description_el.getFirstChild().getData());

rating = strsplit(description, '评分：');
rating = rating{2}(1:end-6);

runtime = strsplit(description, '片长：');
runtime = runtime{2}(1:end-6);

country = strsplit(description, '制片国家/地区：');
country = country{2}(1:end-6);

director = strsplit(description, '导演：');
director = director{2}(1:end-6);

cast = strsplit(description, '主演：');
cast = cast{2}(1:end-6);

image_url = strsplit(description, '<img src="');
image_url = image_url{2}(1:strfind(image_url{2},'"')-1);

% 输出提取的信息
fprintf('Title: %s\n', title);
fprintf('Rating: %s\n', rating);
fprintf('Runtime: %s\n', runtime);
fprintf('Country: %s\n', country);
fprintf('Director: %s\n', director);
fprintf('Cast: %s\n', cast);
fprintf('Image URL: %s\n', image_url);




% 解析XML
%xml = xmlread(textInfo);

% % 遍历每个电影条目并提取信息
% items = xml.getElementsByTagName('item');
% for i=0:items.getLength()-1
%     item = items.item(i);
%     title = char(item.getElementsByTagName('title').item(0).getTextContent().strip()); % 标题
%     rating = char(strsplit(char(item.getElementsByTagName('description').item(0).getTextContent())){2}(3:end)); % 评分
%     runtime = char(strsplit(char(item.getElementsByTagName('description').item(0).getTextContent())){3}(3:end)); % 片长
%     country = char(strsplit(char(item.getElementsByTagName('description').item(0).getTextContent())){4}(3:end)); % 制片国家/地区
%     director = char(strsplit(char(item.getElementsByTagName('description').item(0).getTextContent())){5}(3:end)); % 导演
%     cast = char(strsplit(char(item.getElementsByTagName('description').item(0).getTextContent())){6}(3:end)); % 主演
%     image_url = char(strsplit(char(item.getElementsByTagName('description').item(0).getTextContent())){7}(11:end-2)); % 海报图片链接
% 
%     % 输出提取的信息
%     fprintf('Title: %s\n', title);
%     fprintf('Rating: %s\n', rating);
%     fprintf('Runtime: %s\n', runtime);
%     fprintf('Country: %s\n', country);
%     fprintf('Director: %s\n', director);
%     fprintf('Cast: %s\n', cast);
%     fprintf('Image URL: %s\n', image_url);
%     fprintf('---\n');
% end