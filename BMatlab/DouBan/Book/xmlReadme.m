xml_str = strrep(textInfo, '&quot;', '"');

% д�뵽�µ�XML�ļ�
new_file = 'new_xml_file.xml';
fid = fopen(new_file, 'w');
fprintf(fid, '%s', xml_str);
fclose(fid);