% ɾ����ͷ���������ַ�
if startsWith(textInfo, '"')
    textInfo = textInfo(2:end);
end

% ɾ����β���������ַ�
if endsWith(textInfo, '"')
    textInfo = textInfo(1:end-1);
end

% ��ʾ���
disp(textInfo)