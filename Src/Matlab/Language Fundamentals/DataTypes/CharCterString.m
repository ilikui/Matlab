%%  第一节
Str = "Hello world";

str1 = 'A';


Str2=string(str1);


%%  第二节

Str1  = "Hello";

Str2 = "World";

Str3 = strcat(Str1," ",Str2);


%% 第三节  数据类型判定

Str2 = "1";
a = isstring(Str2);
b = isstring(str2double(Str2));


disp(b)

disp(a)





