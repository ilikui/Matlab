function tf = isPangram(s)
  tf = ~isempty(s)
  s(isspace(s)) = [] ;
  s = lower(s);
  compares ='abcdefghijklmnopqrstuvwxyz';
  
  for n =1:length(compares)
     
      for m = 1:length(s)
           disp(compares(n))
            disp(s(m))
          if compares(n) == s(m)
         
              break;
          end
            
      end
      
  end

   
end




           
