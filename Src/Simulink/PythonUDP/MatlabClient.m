clc
clear

tcpclient = tcpip('127.0.0.1', 5432, 'Timeout', 60,'OutputBufferSize',10240,'InputBufferSize',10240);%�������ip������˿ڵ�UDP������
%t.BytesAvailableFcnMode='byte'
%while(1)
    %a=1:10
    fopen(tcpclient);
    fwrite(tcpclient,'please sent');%����һ�����ݸ�tcp����������������֪��matlab��ip�Ͷ˿�
    while(1) %��ѯ��ֱ������������fread
        nBytes = get(tcpclient,'BytesAvailable');
        if nBytes>0
            break;
        end
    end
    receive = fread(tcpclient,nBytes);%��ȡtcp����������������
    %fread(t)
    %�ر�����
    fclose(tcpclient);
    data=str2num(char(receive(2:end-1)')); %��ASCII��ת��Ϊstr���ٽ�strת��Ϊ����
    disp(data)
%end
delete(tcpclient);