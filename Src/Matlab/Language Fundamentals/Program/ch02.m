
%% 运行脚本

a = uint16(12);

fprintf("a = %d \n",a);


%% 调试 脚本

a =1:1:100;
 for i =1:1:length(a)
     
     if( mod(i,2)  ==0)
         disp("偶数来了");
         fprintf("i = %d\n",i);
         disp("*********************************");
         
     else
         disp("奇数来了");
         fprintf("i = %d\n",i);
         disp("*********************************");
     end
     
 end


disp("a的长度 "+ length(a))