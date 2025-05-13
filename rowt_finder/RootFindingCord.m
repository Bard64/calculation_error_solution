
RootByChord();

function RootByChord()
    % دریافت ورودی‌های عددی
    A = input('What is A : ');
    B = input('What is B : ');
    epsilon = input('precision : ');
    cycle = input('cycle : ');
    
    % دریافت تابع و نماد آن
    [fx, symbol_f] = input_function();
    
    % محاسبه مشتق‌های یکم و دوم به صورت نمادین
    fD1_sym = gradian(fx, symbol_f, 1);
    fD2_sym = gradian(fx, symbol_f, 2);
    
    % تبدیل عبارات نمادین به تابع‌های قابل اجرا
    % (در اینجا ورودی تابع به عنوان متغیر نمادین انتخاب‌شده، مثلاً 'x'، در نظر گرفته می‌شود)
    fD1 = matlabFunction(fD1_sym, 'Vars', {sym(symbol_f)});
    fD2 = matlabFunction(fD2_sym, 'Vars', {sym(symbol_f)});
    fx_fun = matlabFunction(fx, 'Vars', {sym(symbol_f)});
    
    % فراخوانی تابع ریشه‌یابی
    R = vatar(A, B, epsilon, fx_fun, fD1, fD2, cycle);
    disp(R);
end

function result = vatar(A, B, epsilon, def_Formula, D1_def_Formula, D2_def_Formula, cycle)
    % در صورت تعریف نشدن تعداد چرخه‌ها، مقدار پیش‌فرض 1000 در نظر گرفته می‌شود
    if nargin < 7
        cycle = 1000;
    end
    
    res = def_Formula(A) * D2_def_Formula(A);
    if res > 0
        X0 = A;
    else
        X0 = B;
    end

    % حلقه اجرای الگوریتم (تعداد تکرار cycle بار)
    for i = 1:cycle
        X0 = X0 - (def_Formula(X0) / D1_def_Formula(X0));
        
        % شرط بررسی همگرایی
        if def_Formula(X0) < epsilon
            res_X0 = X0;
            res_val = def_Formula(X0);
            err = '';
            break;
        end
        
        % شرط تکراری؛ به علت حفظ منطق اصلی بدون تغییر
        if def_Formula(X0) < epsilon
            res_X0 = NaN;
            res_val = NaN;
            err = "can't find root";
            break;
        end
    end
    
    % قالب‌بندی خروجی به صورت رشته
    result = [repmat('#', 1, 40) newline newline ...
        'Root point is in (X : ' num2str(res_X0) ') and (error : ' num2str(res_val) ')' ...
        ' ## ' char(err) ' ##' newline newline repmat('#', 1, 40)];
end

function f = gradian(fx, simbol, Deg)
    % ورودی: fx عبارت نمادین تابع، simbol: نام متغیر (مثلاً 'x')، Deg: درجه مشتق
    x = sym(simbol);
    f = diff(fx, x, Deg);
end

function [fx, symbol_f] = input_function()
    % دریافت نماد تابع از کاربر (به صورت رشته)
    symbol_f = input('what is your function symbol ? (for example : x): ', 's');
    % دریافت عبارت تابع به صورت رشته، و تبدیل به عبارت نمادین
    fx_str = input('your function (for example : x^3 + 5*x + 2):  ', 's');
    fx = str2sym(fx_str);
    
    confirmation = input([repmat('#', 1, 40) newline newline ...
                          'Your function is ' char(fx) ' ? ' newline ...
                          'Yes: y' newline 'No: Any key' newline newline ...
                          repmat('#', 1, 40) newline], 's');
    if lower(confirmation) == 'y'
        % تایید شده، مقادیر را برگردانیم
    else
        [fx, symbol_f] = input_function(); % فراخوانی مجدد در صورت تایید نشدن
    end
end


