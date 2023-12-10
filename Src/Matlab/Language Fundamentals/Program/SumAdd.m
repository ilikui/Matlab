function y = SumAdd(x1,x2)


    if(nargin == 2)
         y = x1+x2;
    elseif (nargin ~= 2)
        disp("参数不对");    
    else
        disp("未知错误");    
    end


end