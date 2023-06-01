% 删除开头处的引号字符
if startsWith(textInfo, '"')
    textInfo = textInfo(2:end);
end

% 删除结尾处的引号字符
if endsWith(textInfo, '"')
    textInfo = textInfo(1:end-1);
end

% 显示结果
disp(textInfo)