import sys
f2r=str(sys.argv[1])

def assemble(cmnd):
    global counter_modificator, links, address,command_counter
    output=''
    split_cmnd=cmnd.split() #разделение введённой строки по пробелам
    if(split_cmnd[0][0]==':'): #если в начале строки указана метка в формате ": имя адреса"
        address.append(split_cmnd[1]) #сохранить имя адреса в список ссылок
        links.append((bin(command_counter+counter_modificator)).replace('0b','').zfill(17)) #и добавить номер строки на которой находится этот адрес
        del split_cmnd[0] #подготовка команды к
        del split_cmnd[0] #дальнейшему использованию
    if(split_cmnd[0]=='r'): #условные инструкции без загрузки
        counter_modificator+=1 #т.к. условная конструкция ассемблера в машинном коде занимает 2 строки, то нужно добавить 1 для выравнивания адреса перехода
        del split_cmnd[0]
        output_preparator=list('')
        output_preparator.append('00001101100000001000\n') #A-B

        i=0;
        while i<len(icml): #заменить условную команду на код перехода
            split_cmnd[0]=split_cmnd[0].replace(icml[i],icdl[i]) 
            i+=1
            
        i=0
        output_preparator.append(str(split_cmnd[0]))
        
        i=0
        while i<len(address): #заменить имя адреса на номер строки его нахождения
            if(split_cmnd[1].find(address[i])!=-1):
                split_cmnd[1]=split_cmnd[1].replace(address[i],links[i])
                break
                
            i+=1
        else:
            split_cmnd[1]=split_cmnd[1].replace(split_cmnd[1],(bin(int(split_cmnd[1]))).replace('0b','').zfill(17)) #если не найдено, то перейти по адресу в двоичном виде
            
        i=0
        output_preparator.append(str(split_cmnd[1])+'\n')
        output=output.join(output_preparator)
    elif(split_cmnd[0][0]=='b'): #условные инструкции
        output_preparator=list('')
        if (split_cmnd[1]=='int'): #если int, то ожидать ввода по DataIn. Иначе - загрузить переменную из БРОН
            output_preparator.append('00000000000100000001\n')
        else:
            output_preparator.append('0000000000000'+split_cmnd[1].replace(split_cmnd[1],(bin(int(split_cmnd[1]))).replace('0b','').zfill(3))+'0001\n')
            
        output_preparator.append('0000000000000'+split_cmnd[2].replace(split_cmnd[2],((bin(int(split_cmnd[2]))).replace('0b','').zfill(3)))+'0110\n') #загрузка из БРОН в RgB
        output_preparator.append('00001101100000001000\n') #A-B и подать её на выход (v[3]=1)
        
        i=0;
        while i<len(icml): #заменить условную команду на код перехода
            split_cmnd[0]=split_cmnd[0].replace(icml[i],icdl[i]) 
            i+=1
            
        i=0
        while i<len(address): #заменить имя адреса на номер строки его нахождения
            if(split_cmnd[3].find(address[i])!=-1):
                split_cmnd[3]=split_cmnd[3].replace(address[i],links[i])
                break
                
            i+=1
        else:
            split_cmnd[3]=split_cmnd[3].replace(split_cmnd[3],(bin(int(split_cmnd[3]))).replace('0b','').zfill(17)) #если не найдено, то перейти по адресу в двоичном виде
            
        i=0
        
        output_preparator.append(split_cmnd[0]+split_cmnd[3]+'\n') #сформировать команду перехода
        counter_modificator+=3 #т.к. условная конструкция ассемблера в машинном коде занимает 4 строки, то нужно добавить 3 для выравнивания адреса перехода
        
        output=output.join(output_preparator) #подготовить выходные строки
        
    elif (split_cmnd[0]=='jump'):
        i=0
        while i<len(address): #заменить имя адреса на номер строки его нахождения
            if(split_cmnd[1].find(address[i])!=-1):
                split_cmnd[1]=split_cmnd[1].replace(address[i],links[i])
                break
                
            i+=1
        else:
            split_cmnd[1]=split_cmnd[1].replace(split_cmnd[1],(bin(int(split_cmnd[1]))).replace('0b','').zfill(17)) #если не найдено, то перейти по адресу в двоичном виде
            
        i=0
        
        output='111' + split_cmnd[1] + '\n'
    else: #безусловные инструкции
        if(len(split_cmnd)==1):
            i=0
            while i<len(ocml): #заменить команду на код
                split_cmnd[0]=split_cmnd[0].replace(ocml[i],ocdl[i])
                i+=1
                
            i=0
            output=split_cmnd[0]+'\n'
        
        if(len(split_cmnd)==2):
            i=0
            while i<len(tcml):
                if(split_cmnd[0].find(tcml[i])!=-1):
                    output=(tcdl[i].split())[0]+(bin(int(split_cmnd[1]))).replace('0b','').zfill(3)+(tcdl[i].split())[1]+'\n'
                    break
                
                i+=1
            
        if(len(split_cmnd)==3):
            i=0
            while i<len(tcml):
                if(split_cmnd[0].find(tcml[i])!=-1):
                    output=(tcdl[i].split())[0]+(bin(int(split_cmnd[1]))).replace('0b','').zfill(3)+'1000'+'\n'
                    break
                
                i+=1
    
    
    return output
    

asmfile=open(f2r+'.txt','r') 
binfile=open('../'+f2r+'.bin','w')

ocm=open('1lcommands.txt','r')
ocd=open('1lcodes.txt','r')
tcm=open('2lcommands.txt','r')
tcd=open('2lcodes.txt','r')
icm=open('ifcommands.txt','r')
icd=open('ifcodes.txt','r')

global ocml,ocdl,tcml,tcdl,icml,icdl
ocml=[line.strip() for line in ocm]
ocdl=[line.strip() for line in ocd]
tcml=[line.strip() for line in tcm]
tcdl=[line.strip() for line in tcd]
icml=[line.strip() for line in icm]
icdl=[line.strip() for line in icd]

global counter_modificator, links, address,command_counter
command_counter=0 #счётчик строк
counter_modificator=0 #условные команды добавлют 3
links=list('')
address=list('')

for line in asmfile:
    binfile.write(assemble(line))
    command_counter+=1
    
asmfile.close()
binfile.close()
ocm.close()
ocd.close()
tcm.close()
tcd.close()
icm.close()
icd.close()
