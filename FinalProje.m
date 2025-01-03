%clc;
%clear all;

veri=xlsread('C:\Users\ceyda\Desktop\GitHub\Matlab\veri-onisleme\verisetim.csv','B2:N616');
yeniveri=veri;

while(1==1)
    fprintf('\n');
    disp('--------------------------------'); 
    disp('[1] Ortalama Ile Eksik Veri Tamamlama');    
    disp('[2] Ortalama Hesapla'); 
    disp('[3] Medyan Hesapla'); 
    disp('[4] Mod Hesapla');
    disp('[5] Frekans Hesapla'); 
    disp('[6] IQR Hesapla'); 
    disp('[7] Aykiri Degerleri Bul'); 
    disp('[8] 5 Say� Ozeti'); 
    disp('[9] Kutu Grafigi'); 
    disp('[10] Varyans ve Standart Sapma Hesapla'); 
    disp('[11] Cikis');

    secim=input('Secim yapin: ');
    cikis=0;
    switch secim
        
        case 1
            disp('--Ortalama ile Eksik Veri Tamamlama--');
            [I,J]=find(isnan(veri));
            eksikindeks=[I J];
            [verisay,sutunsay]=size(veri);
            eksikverisay= size(eksikindeks,1);
            
            for i=1:eksikverisay
                sat = eksikindeks(i,1);
                sut = eksikindeks(i,2);
                tumsatirlar=yeniveri(:,sut);
                nanolmayanlar=tumsatirlar(~isnan(tumsatirlar));
                ort=mean(nanolmayanlar);
                yeniveri(sat,sut)=ort;
            end
            disp('Eksik veriler tamamlandi.');

            
        case 2
            disp('--Ortalama Hesaplama--');
            [verisay,sutunsay]=size(yeniveri);
            sutun=sutunsay(~isnan(sutunsay));
            satir=verisay(~isnan(verisay));
            toplam=0;
            ort=0;
            for i=1:sutun
                toplam=0;
                for j=1:satir
                toplam= toplam+yeniveri(j,i);
                end
                ort=toplam/verisay;
                fprintf('%d. sutunun ortalamasi: %.2f\n',i,ort);
                ort=0;
            end
            
            
        case 3
            disp('--Medyan Hesaplama--');
            [verisay,sutunsay]=size(yeniveri);
            sutun=sutunsay(~isnan(sutunsay));
            satir=verisay(~isnan(verisay));
            for i=1:sutun
                siraliveri=sort(yeniveri(:,i));
                ortancaindex=(satir+1)/2;
                if mod(satir,2)==0
                    index1=satir/2;
                    index2=(satir/2)+1;
                    medyan=(siraliveri(index1,1)+siraliveri(index2,1))/2;
                else
                    medyan=siraliveri(ortancaindex,1);
                end
                fprintf('%d. sutunun medyani= %.2f\n',i,medyan);
                
            end
            
        case 4
            disp('--Mod Hesaplama--');
            [verisay,sutunsay]=size(yeniveri);
            sutun=sutunsay(~isnan(sutunsay));
            satir=verisay(~isnan(verisay));
            
            
            for i=1:sutun
                siraliveri=sort(yeniveri(:,i));
                tekilveri=unique(siraliveri);
                tekilveriadet = size(tekilveri,1);
                tekilveri = [tekilveri zeros(tekilveriadet,1)];
                
                for j=1:tekilveriadet
                    deger = tekilveri(j,1);
                    sonucDizi = siraliveri == deger; 
                    tekilveri(j,2)=sum(sonucDizi); 
                end
                maxFrekans=max(tekilveri(:,2));
                ModIndexler=find(tekilveri(:,2) == maxFrekans);
                fprintf('%d. sutunun modlari:\n',i);
                for j=1:size(ModIndexler,1)
                    fprintf( '\t%d.Mod: %.2f frekansi: %d\n',j,tekilveri(ModIndexler(j,1),1),maxFrekans);
                end
            end
            
            
        case 5
            disp('--Frekans Hesaplama--');
            sutungir=input('Frekans hesaplatmak istediginiz sutunu giriniz:');
            sutun=sort(yeniveri(:,sutungir));
            tekilveri = unique(sutun);
            tekilveriadet = size(tekilveri,1);
            tekilveri = [tekilveri zeros(tekilveriadet,1)];
            for i=1:tekilveriadet
                deger = tekilveri(i,1);
                sonucDizi = sutun == deger; 
                tekilveri(i,2)=sum(sonucDizi); 
            end
            disp(tekilveri);
            bar(tekilveri(:,1),tekilveri(:,2));
            
            
        case 6
            disp('--IQR Hesaplama--');
            [verisay,sutunsay]=size(yeniveri);
            sutun=sutunsay(~isnan(sutunsay));
            satir=verisay(~isnan(verisay));
            for i=1:sutun
                verisayisi=size(yeniveri,1);
                siraliveri=sort(yeniveri(:,i));

                indexQ1=(25/100)*(verisayisi+1); 
                if ~isa(indexQ1,'float')
                   index1=floor(indexQ1);
                   index2=ceil(indexQ1);

                   Q1=(siraliveri(index1,1)+siraliveri(index2,1))/2;

                else
                  Q1= siraliveri(indexQ1,1);

                end

                indexQ3=(75/100)*(verisayisi+1); 
                if ~isa(indexQ3,'float')
                   index1=floor(indexQ3);
                   index2= ceil(indexQ3);

                   Q3=(siraliveri(index1,1)+siraliveri(index2,1))/2;

                else
                  Q3= siraliveri(indexQ3,1);

                end
                IQR= Q3-Q1;
                fprintf('Q1=%.2f Q3=%.2f ---',Q1,Q3);
                fprintf('%d. sutunun IQR degeri= %.2f\n',i,IQR);
            end
            
        case 7
            disp('--Aykiri Degerler--');
            [verisay,sutunsay]=size(yeniveri);
            sutun=sutunsay(~isnan(sutunsay));
            satir=verisay(~isnan(verisay));
            for i=1:sutun
                verisayisi=size(yeniveri,1);
                siraliveri=sort(yeniveri(:,i));

                indexQ1=(25/100)*(verisayisi+1); 
                if ~isa(indexQ1,'float')
                   index1=floor(indexQ1);
                   index2=ceil(indexQ1);

                   Q1=(siraliveri(index1,1)+siraliveri(index2,1))/2;

                else
                  Q1= siraliveri(indexQ1,1);

                end

                indexQ3=(75/100)*(verisayisi+1); 
                if ~isa(indexQ3,'float')
                   index1=floor(indexQ3);
                   index2= ceil(indexQ3);

                   Q3=(siraliveri(index1,1)+siraliveri(index2,1))/2;

                else
                  Q3= siraliveri(indexQ3,1);

                end
                IQR= Q3-Q1;
                ust = Q3+IQR*1.5;
                alt = Q1-IQR*1.5;
                fprintf('\n%d sutununun aykiri degerleri: \n',i);
                aykiriveriler=[];
                for j=1:verisayisi
                    if siraliveri(j,1)<alt || siraliveri(j,1)>ust
                        if ismember(siraliveri(j,1),aykiriveriler)
                            continue;
                        else
                            aykiriveriler=[aykiriveriler;siraliveri(j,1)];
                            fprintf('%.2f - ',siraliveri(j,1));
                        end
                    end
                    
                end
                          
            end
        case 8
            disp('--5 Sayi Ozeti--');
            [verisay,sutunsay]=size(yeniveri);
            sutun=sutunsay(~isnan(sutunsay));
            satir=verisay(~isnan(verisay));
            for i=1:sutun
                verisayisi=size(yeniveri,1);
                siraliveri=sort(yeniveri(:,i));

                indexQ1=(25/100)*(verisayisi+1); 
                if ~isa(indexQ1,'float')
                   index1=floor(indexQ1);
                   index2=ceil(indexQ1);

                   Q1=(siraliveri(index1,1)+siraliveri(index2,1))/2;

                else
                  Q1= siraliveri(indexQ1,1);

                end

                indexQ3=(75/100)*(verisayisi+1); 
                if ~isa(indexQ3,'float')
                   index1=floor(indexQ3);
                   index2= ceil(indexQ3);

                   Q3=(siraliveri(index1,1)+siraliveri(index2,1))/2;

                else
                  Q3= siraliveri(indexQ3,1);

                end
                IQR= Q3-Q1;
                medyan=median(yeniveri(:,i));
                maxDeger = max(yeniveri(:,i));
                minDeger = min(yeniveri(:,i));
                fprintf('\n%d. sutunun 5 sayi ozeti:\n',i);
                fprintf('\tMinimum deger: %.2f\n',minDeger)
                fprintf('\tBirinci ceyrek: %.2f\n',Q1)
                fprintf('\tMedyan: %.2f\n',medyan)
                fprintf('\tUcuncu ceyrek: %.2f\n',Q3)
                fprintf('\tMaksimum deger: %.2f\n',maxDeger)
            end
            
        case 9
            disp('--Kutu Grafigi--');
            boxplot(yeniveri);
            
        case 10
            disp('--Varyans ve Standart Sapma--');
            [verisay,sutunsay]=size(yeniveri);
            sutun=sutunsay(~isnan(sutunsay));
            satir=verisay(~isnan(verisay));
            for i=1:sutun
                toplam=0;
                ort=mean(yeniveri(:,i));
                for j=1:satir
                    fark=yeniveri(j,i)-ort;
                    toplam=toplam+fark*fark;
                end
                varyans=toplam/verisay;
                standart=sqrt(varyans);
                std1=std(yeniveri(:,13));
                fprintf('%d.sutunun:\n',i);
                fprintf('\tVaryansi= %.2f Standart sapmasi= %.2f\n',varyans,standart);
                
            end
            
        case 11
            cikis=1;
            
        otherwise
            disp('------------');
            disp('Hatali giris!');

    end
    if(cikis==1)
        break;
    end

end
