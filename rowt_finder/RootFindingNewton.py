from sympy import symbols, diff,sympify,lambdify

def vatar(A:float,B:float,epsilon:float,def_Formula,D1_def_Formula,D2_def_Formula,cycle=1000):
    res = def_Formula(A)*D2_def_Formula(A)
    if res>0:
        X0 = A
    else :
        X0 = B

    while range(cycle):
        
        X0 = X0 - (def_Formula(X0)/D1_def_Formula(X0))

        if def_Formula(X0)<epsilon:
            res_X0 = X0 
            res = def_Formula(X0)
            err=''
            break
        if def_Formula(X0)<epsilon:
            res_X0 = 'err' 
            res = 'err'
            err = "can't find root"
            break    
    
    return('#'*40+'\n\n'+f'Root point is in (X : {res_X0}) and (error : {res})'+f'## {err} ##'+'\n\n'+'#'*40)

def gradian(fx:str,simbol:str,Deg:int):
    x = symbols('x')
    f = diff(fx,x,Deg)
    return f

def input_function():
    symbol_f = input("what is your function symbol ? (for example : X): ")
    fx = sympify(input("your function (for example : x**3 + 5x + 2):  "))
    try:
        checking = input('#'*40+'\n'*2+f'Your function is {fx} ? \nYes: y\nNo: Any key'+'\n'*2+'#'*40)
    except:
        input_function()
    if checking == 'y':
        return fx,symbol_f
    else:
        input_function()
    

def RootByChord():
    try:
        A=float(input("What is A : "))
        B=float(input("What is B : "))
        epsilon =float(input("precision : "))
        cycle = int(input('cycle :'))
    except:
        pass
    try:
        A+B+epsilon+cycle
    except:
        RootByChord()
    
    fx,symbol_f = input_function()

    fD1=gradian(fx,symbol_f,1)
    fD2=gradian(fx,symbol_f,2)
    fD1 = lambdify(symbol_f,fD1)
    fD2 = lambdify(symbol_f,fD2)
    fx = lambdify(symbol_f,fx)
    R=vatar(A=A,B=B,epsilon=epsilon,def_Formula=fx,D1_def_Formula=fD1,D2_def_Formula=fD2)
    print(R)

RootByChord()
