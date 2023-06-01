xml_str = strrep(textInfo, '&quot;', '"');

% 写入到新的XML文件
new_file = 'new_xml_file.xml';
fid = fopen(new_file, 'w');
fprintf(fid, '%s', xml_str);
fclose(fid);