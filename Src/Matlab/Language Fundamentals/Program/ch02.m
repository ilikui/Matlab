
%% ���нű�

a = uint16(12);

fprintf("a = %d \n",a);


%% ���� �ű�

a =1:1:100;
 for i =1:1:length(a)
     
     if( mod(i,2)  ==0)
         disp("ż������");
         fprintf("i = %d\n",i);
         disp("*********************************");
         
     else
         disp("��������");
         fprintf("i = %d\n",i);
         disp("*********************************");
     end
     
 end


disp("a�ĳ��� "+ length(a))