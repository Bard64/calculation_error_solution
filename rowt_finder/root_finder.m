
a = input(' :  نقطه منفی');
b = input(':  نقطه مثبت ');
j = input('ماکسیموم خطا');
F = input("تابع فرمول را وارد کنید: پیشفرض(@(x) x-(0.5*cos(x))) : ");
Maxiter = input(' :تعداد جرخه(بیش فرض 1000)')



a=-100
b=100
j=0.001

if isempty(Maxiter)  
    Maxiter =1000;
end

if isempty(F)
    F = @(x) x - (0.5 * cos(x));
end


a=finder(a,b,j,F,Maxiter);
fprintf('ریشه معادله: %.6f\n',a)


function res = finder(a,b,j,F,Maxiter)
    for i= 1:Maxiter
        C=(a+b)/2;
    
        if abs(F(C))<j

            res=C;
        end
        if F(a)*F(C) >0
            a=C;
               
        else
            b=C;
        end
       
    end
    
end
         
