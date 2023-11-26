N,a1,a2,a3,a4,a6 = map(int,input().split())
a = [a1,a2,a3,a4,a6]
R.<x,y> = IntegerModRing(N)['x,y']
f = y**2+a1*x*y+a3*y - (x**3 + a2*x**2 + a4*x + a6)
def delta(k,a):
    a1,a2,a3,a4,a6 = map(k,a)
    b2 = a1**2+4*a2
    b4 = 2*a4 + a1*a3
    b6 = a3**2 + 4*a6
    b8 = a1**2*a6+4*a2*a6-a1*a3*a4+a2*a3**2-a4**2
    return -b2**2*b8-8*b4**3-27*b6**2+9*b2*b4*b6
def c4(k,a):
    a1,a2,a3,a4,a6 = map(k,a)
    b2 = a1**2+4*a2
    b4 = 2*a4 + a1*a3
    b6 = a3**2 + 4*a6
    b8 = a1**2*a6+4*a2*a6-a1*a3*a4+a2*a3**2-a4**2
    return b2**2-24*b4
def solve_quadratic_equation(k,a,b,c):
    assert(a!=0)
    a,b,c = (k(a),k(b),k(c))
    tmp = (b**2-4*a*c)
    return [(-b+tmp.sqrt())/(2*a),(-b-tmp.sqrt())/(2*a)]
def two_torsion_point(k,a):
    a1,a2,a3,a4,a6 = map(k,a)
    RR.<x,y> = k['x,y']
    f = y**2+a1*x*y+a3*y - (x**3 + a2*x**2 + a4*x + a6)
    dfdx = a1*y-3*x**2-2*a2*x-a4
    dfdy = 2*y+a1*x+a3
    if a1==0:
        y0 = -a3/2
    else :
        y0 = (-a1*x-a3)/2
    R.<x> = k['x']
    f0 = R(f(x,y0))
    ansx = f0.roots()
    assert len(ansx)!=0
    x0 = ansx[0][0]
    if a1!=0:
    	y0 = (-a1*x0-a3)/2
    assert x0 in k
    assert f(x0,y0)==0
    assert not (dfdx(x0,y0) == 0 and dfdy(x0,y0) ==0)
    return (x0,y0)
def random_point(k,a):
    a1,a2,a3,a4,a6 = map(k,a)
    RR.<x,y> = k['x,y']
    f = y**2+a1*x*y+a3*y - (x**3 + a2*x**2 + a4*x + a6)
    while True:
        x0 = k.random_element()
        f0 = f(x0,y)
        y0 = solve_quadratic_equation(k,k(f0.coefficient({x:0,y:2})),k(f0.coefficient({x:0,y:1})),k(f0.coefficient({x:0,y:0})))
        if len(y0)!=0 and (y0[0] in k ):
            y0 = k(y0[0])
            break
    assert f(x0,y0) == 0
    assert x0 in k and y0 in k
    return (x0,y0)


R = IntegerModRing(N)
assert delta(R,a) == 0
p = int(gcd(c4(R,a),N)) #cusp
q = N//p #node
assert p*q == N

kp = GF(p)
kq = GF(q)
R0 = IntegerModRing(p*q)

Pp = random_point(kp,a)
Pq = two_torsion_point(kq,a)
P = (Pp[0].crt(Pq[0]),Pp[1].crt(Pq[1]))
assert P[0] in R0 and P[1] in R0
assert f(P[0],P[1]) == 0
print(P[0],P[1])
