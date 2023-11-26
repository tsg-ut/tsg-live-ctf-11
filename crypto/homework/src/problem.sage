# We DON'T think you need to worry too much about this file.
from secret import flag
from sys import exit
from elliptic_curve import EC


def delta(R,f):
    k = R.base()
    x,y = R.gens()
    a1,a2,a3,a4,a6 = map(k,[f.coefficient({x:1,y:1}),-f.coefficient({x:2,y:0}),f.coefficient({x:0,y:1}),
                            -f.coefficient({x:1,y:0}),-f.coefficient({x:0,y:0})])
    b2 = a1**2 + 4*a2
    b4 = 2*a4+a1*a3
    b6 = a3**2+4*a6
    b8 = a1**2*a6+4*a2*a6-a1*a3*a4+a2*a3**2-a4**2
    delta = -b2**2*b8-8*b4**3-27*b6**2+9*b2*b4*b6
    return delta
def gen_cusp(R):
    k = R.base()
    x,y = R.gens()
    assert k.characteristic() != 2 and k.characteristic() != 3
    a,b,c,d = [k.random_element() for i in range(4)]
    X = x + a
    Y = y + b*X + c
    f = Y**2 - (X+d)**3
    assert delta(R,f) == k(0)
    return f
def gen_node(R):
    k = R.base()
    x,y = R.gens()
    assert k.characteristic() != 2 and k.characteristic() != 3
    c6 = k.random_element()
    RR.<d> = k['d']
    f = d**3 - c6**2
    c4 = f.roots()[0][0]
    a,b,c = [k.random_element() for i in range(3)]
    X = x + a
    Y = y + b*X + c
    f = Y**2-X**3+27*c4*X+54*c6
    assert delta(R,f) == k(0)
    return f
def gen_problem(p,q):
    K = [GF(p),GF(q)]
    R = [k['x,y'] for k in K]
    k1.<x1,y1> = R[0]
    k2.<x2,y2> = R[1]
    X = [x1,x2]
    Y = [y1,y2]
    F = [gen_cusp(R[0]),gen_node(R[1])]
    ModPQ = IntegerModRing(p*q)
    RR.<x,y> = ModPQ['x,y']
    f = 0
    for i in range(4):
        for j in range(3):
            f += K[0](F[0].coefficient({X[0]:i,Y[0]:j})).crt( K[1](F[1].coefficient({X[1]:i,Y[1]:j})) ) * x**i * y**j
    assert delta(RR,f) == ModPQ(0)
    return (f,F)

def weierstrass_params(R,f):
    k = R.base_ring()
    x,y = R.gens()
    return list(map(k,[(f.coefficient({x:1,y:1})),(-f.coefficient({x:2,y:0})),(f.coefficient({x:0,y:1})),(-f.coefficient({x:1,y:0})),(-f.coefficient({x:0,y:0}))]))

while True:
	try:
		p = random_prime(2**256,lbound=2**220)
		q = random_prime(2**256,lbound=2**220)

		N = p * q
		f,F = gen_problem(p,q)

		a1,a2,a3,a4,a6 = weierstrass_params(f.parent(),f)
		break
	except:
		pass

R = f.base_ring()

ec = EC(R, (a1, a2, a3, a4, a6))

print(N,a1,a2,a3,a4,a6)

try:
	x,y = P = map(int,input().split())
except:
	print("Invalid input.")
	exit()

if not ec.iszeropoint((x,y)):
	print("This is not a point on the elliptic curve.")
	exit()

try:
	ec.scalar(3,P)
except:
	print("Congraturation!",flag.decode('ascii'))

