function tf = mono_increase(x)


     tf = true;
    for n=1:length(x)-1
       
        if x(n+1)<x(n) 
            tf = false;
        end
    end
end