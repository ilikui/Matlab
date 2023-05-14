%% webread function test
% V2EX API
BaseHttp = "https://www.v2ex.com/api/topics/hot.json";
options = weboptions();

v2ex=webread(BaseHttp);