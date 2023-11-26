p = 2
q = 3
r = 5

R.<x> = IntegerModRing(p*q*r)['x']
Rp.<X> = GF(p)['x']
Rq.<X> = GF(q)['x']
Rr.<X> = GF(r)['x']

f = x^194 + 12*x^193 + 28*x^192 + 18*x^191 + 17*x^190 + 27*x^189 + 2*x^188 + 19*x^187 + 27*x^185 + 11*x^184 + 2*x^183 + 26*x^182 + 17*x^181 + 5*x^179 + 5*x^178 + 16*x^177 + 6*x^176 + x^175 + 13*x^174 + 4*x^173 + 27*x^172 + 20*x^171 + 28*x^170 + 26*x^169 + 18*x^168 + 9*x^167 + 15*x^166 + 11*x^165 + 12*x^164 + 12*x^163 + 21*x^162 + 21*x^161 + 6*x^160 + 21*x^159 + 18*x^158 + 7*x^157 + 29*x^156 + x^155 + 2*x^154 + 13*x^153 + 24*x^152 + 13*x^151 + 24*x^150 + 27*x^149 + 9*x^148 + 20*x^147 + 4*x^146 + 26*x^145 + 29*x^144 + 3*x^143 + 19*x^142 + 19*x^141 + 3*x^140 + 5*x^139 + 11*x^138 + 2*x^137 + 19*x^136 + 4*x^135 + 13*x^134 + 23*x^133 + 22*x^132 + 12*x^131 + 23*x^130 + 12*x^129 + 27*x^127 + 24*x^126 + 18*x^125 + 8*x^124 + 22*x^123 + 4*x^122 + 11*x^121 + 18*x^120 + 14*x^119 + 13*x^118 + 22*x^117 + 20*x^116 + 17*x^115 + 23*x^114 + 24*x^113 + 11*x^112 + 27*x^111 + 29*x^110 + 10*x^109 + 17*x^108 + 29*x^107 + 3*x^106 + 27*x^105 + 3*x^104 + 25*x^103 + 9*x^102 + 29*x^101 + 9*x^100 + 17*x^99 + 18*x^98 + 28*x^97 + 27*x^96 + 14*x^95 + 5*x^94 + 13*x^93 + 3*x^92 + 7*x^91 + 8*x^90 + 23*x^89 + 19*x^88 + 6*x^87 + 28*x^86 + 11*x^84 + 27*x^83 + 15*x^82 + 26*x^81 + 16*x^80 + 3*x^79 + 26*x^78 + x^77 + 25*x^76 + 8*x^75 + 14*x^74 + 9*x^73 + x^72 + 8*x^71 + 14*x^70 + 18*x^69 + 23*x^68 + 19*x^67 + 2*x^66 + 26*x^65 + 13*x^63 + 8*x^62 + 9*x^61 + 4*x^60 + 25*x^59 + 10*x^58 + 4*x^57 + 15*x^56 + 12*x^55 + 10*x^54 + 8*x^53 + 4*x^52 + 4*x^51 + 10*x^50 + 3*x^49 + 15*x^48 + 2*x^47 + 15*x^46 + x^45 + 8*x^44 + 20*x^43 + 13*x^42 + 15*x^41 + 3*x^40 + 19*x^39 + 9*x^38 + 26*x^37 + 16*x^36 + 3*x^35 + 23*x^34 + 4*x^33 + 18*x^31 + 16*x^30 + 2*x^29 + 15*x^28 + 4*x^27 + 28*x^26 + 24*x^25 + 26*x^24 + 9*x^23 + 8*x^21 + 29*x^20 + 28*x^19 + 28*x^18 + 17*x^17 + 18*x^16 + 2*x^15 + 10*x^14 + 23*x^13 + 19*x^12 + 4*x^11 + x^10 + 6*x^9 + 19*x^8 + 3*x^7 + 25*x^6 + 3*x^5 + 17*x^4 + 10*x^3 + 20*x^2 + 8*x + 29

fp = Rp(f)
fq = Rq(f)
fr = Rr(f)

def calc_quotient_mul_order(R,f):
    f = factor(f)
    calc_ord= lambda x,a,n: (x**((a-1)*n))*(x**n-1)
    ret = 1
    for p,i in f:
        print(p,i)
        ret = lcm([ret,calc_ord(R.base_ring().order(),i,p.degree())])
    return ret

ord = lcm([calc_quotient_mul_order(Rp,fp),calc_quotient_mul_order(Rq,fq),calc_quotient_mul_order(Rr,fr)])

S = R.quo(f)
xbar, = S.gens()

g = S(8*x^193 + 4*x^192 + 3*x^191 + 14*x^190 + 16*x^189 + 17*x^188 + 28*x^187 + 29*x^186 + 25*x^185 + 4*x^184 + 15*x^183 + 16*x^182 + 23*x^181 + 21*x^180 + 28*x^179 + 24*x^177 + 25*x^176 + 11*x^175 + 19*x^174 + 16*x^173 + 21*x^172 + 20*x^171 + x^170 + 21*x^169 + 25*x^168 + 2*x^167 + 11*x^166 + 9*x^165 + 22*x^164 + 13*x^163 + 6*x^162 + 25*x^160 + 13*x^159 + 8*x^158 + 5*x^157 + 19*x^156 + 7*x^155 + 8*x^154 + 12*x^153 + 23*x^152 + 24*x^151 + 24*x^150 + 18*x^149 + 9*x^148 + 29*x^147 + 23*x^146 + 7*x^145 + 14*x^144 + 21*x^143 + 29*x^142 + 3*x^141 + 8*x^139 + x^138 + 16*x^137 + 27*x^136 + 14*x^135 + 14*x^134 + 20*x^133 + 20*x^132 + 19*x^131 + 13*x^130 + 3*x^129 + 9*x^128 + 3*x^127 + 15*x^126 + 21*x^125 + 10*x^124 + 17*x^123 + 12*x^122 + 4*x^121 + 16*x^120 + 22*x^119 + 14*x^118 + 24*x^117 + 19*x^115 + 25*x^114 + 14*x^113 + 6*x^112 + 16*x^111 + 24*x^110 + 24*x^109 + x^108 + 17*x^106 + 16*x^105 + 20*x^104 + 6*x^103 + 28*x^102 + 29*x^101 + 6*x^100 + 24*x^99 + 15*x^98 + 25*x^97 + 17*x^96 + 16*x^95 + 2*x^94 + 22*x^93 + 20*x^92 + 13*x^91 + 15*x^90 + 3*x^89 + 4*x^88 + 15*x^87 + 8*x^86 + 7*x^85 + 16*x^84 + 28*x^83 + 4*x^81 + 18*x^80 + 26*x^79 + 10*x^78 + 7*x^77 + 21*x^76 + 23*x^75 + 6*x^74 + 22*x^73 + 25*x^72 + 16*x^71 + 20*x^70 + 15*x^69 + 16*x^68 + 28*x^67 + x^66 + 13*x^65 + 26*x^64 + 27*x^63 + 20*x^62 + 25*x^61 + x^60 + 3*x^59 + 16*x^58 + 16*x^57 + 17*x^55 + 23*x^54 + 11*x^53 + 10*x^52 + 22*x^51 + 18*x^50 + 2*x^49 + 28*x^48 + 19*x^47 + 28*x^46 + 5*x^45 + 13*x^44 + x^43 + 6*x^42 + 27*x^41 + 12*x^40 + 12*x^39 + x^38 + 19*x^37 + 13*x^36 + 10*x^35 + 14*x^34 + 2*x^33 + 27*x^32 + 9*x^31 + 27*x^30 + 9*x^29 + 28*x^28 + 28*x^27 + 14*x^26 + 25*x^25 + 23*x^24 + 24*x^23 + 21*x^22 + 29*x^21 + 16*x^20 + 5*x^19 + 15*x^18 + 9*x^17 + 28*x^16 + 18*x^15 + 2*x^14 + 17*x^13 + 14*x^12 + 24*x^11 + 10*x^10 + 2*x^9 + 21*x^8 + 9*x^7 + 27*x^6 + 21*x^5 + 19*x^4 + 14*x^3 + 11*x^2 + 23*x + 18)

y = 21*xbar^193 + 3*xbar^192 + 23*xbar^191 + 22*xbar^190 + xbar^189 + 12*xbar^188 + 12*xbar^187 + 21*xbar^186 + 21*xbar^185 + 9*xbar^184 + 9*xbar^183 + 22*xbar^182 + 29*xbar^181 + 14*xbar^180 + 21*xbar^179 + 14*xbar^177 + 24*xbar^176 + 20*xbar^175 + 20*xbar^174 + 8*xbar^173 + 27*xbar^171 + 12*xbar^170 + 23*xbar^169 + 5*xbar^168 + 16*xbar^167 + 3*xbar^166 + 5*xbar^165 + 26*xbar^164 + 11*xbar^163 + 4*xbar^162 + 4*xbar^161 + 14*xbar^160 + 4*xbar^159 + 7*xbar^158 + 19*xbar^157 + 20*xbar^156 + 13*xbar^155 + 26*xbar^154 + 12*xbar^153 + 17*xbar^152 + 17*xbar^151 + 13*xbar^150 + 16*xbar^149 + 13*xbar^148 + 9*xbar^147 + 18*xbar^146 + 15*xbar^145 + 16*xbar^144 + 10*xbar^143 + 21*xbar^142 + 24*xbar^141 + 8*xbar^140 + 15*xbar^139 + 8*xbar^138 + 11*xbar^137 + 21*xbar^136 + 25*xbar^135 + 3*xbar^134 + 14*xbar^133 + 18*xbar^132 + xbar^131 + 13*xbar^130 + 21*xbar^129 + 18*xbar^128 + 6*xbar^127 + 17*xbar^126 + 11*xbar^125 + 20*xbar^124 + 23*xbar^123 + 14*xbar^122 + 5*xbar^121 + 8*xbar^120 + 25*xbar^119 + 16*xbar^118 + 21*xbar^117 + 18*xbar^116 + 20*xbar^115 + 10*xbar^114 + 4*xbar^113 + 11*xbar^112 + 4*xbar^111 + 7*xbar^110 + 29*xbar^109 + 3*xbar^108 + 29*xbar^107 + 12*xbar^106 + 10*xbar^105 + 18*xbar^104 + 5*xbar^103 + 22*xbar^102 + 12*xbar^101 + 19*xbar^100 + 8*xbar^99 + 26*xbar^98 + 16*xbar^97 + 9*xbar^96 + 22*xbar^95 + 4*xbar^94 + 14*xbar^93 + 10*xbar^92 + 16*xbar^91 + 12*xbar^90 + 17*xbar^89 + 8*xbar^88 + 17*xbar^87 + 25*xbar^86 + 17*xbar^85 + 9*xbar^84 + 18*xbar^83 + 6*xbar^82 + 15*xbar^81 + 10*xbar^80 + 13*xbar^78 + 5*xbar^76 + 9*xbar^75 + 18*xbar^74 + 22*xbar^73 + 12*xbar^72 + 29*xbar^71 + 29*xbar^70 + 19*xbar^69 + 17*xbar^68 + 5*xbar^67 + 29*xbar^66 + 26*xbar^65 + 12*xbar^64 + 21*xbar^63 + 22*xbar^62 + 14*xbar^60 + 5*xbar^59 + 29*xbar^58 + 9*xbar^57 + 3*xbar^56 + 26*xbar^55 + 19*xbar^53 + 25*xbar^52 + 4*xbar^51 + 3*xbar^50 + 10*xbar^49 + 9*xbar^48 + 2*xbar^47 + 22*xbar^46 + 20*xbar^45 + 27*xbar^44 + 21*xbar^43 + 16*xbar^42 + 15*xbar^41 + 28*xbar^40 + 7*xbar^39 + 11*xbar^38 + 5*xbar^37 + 7*xbar^36 + 20*xbar^35 + 14*xbar^34 + 21*xbar^33 + 5*xbar^32 + 8*xbar^31 + 22*xbar^30 + 11*xbar^29 + 13*xbar^28 + 8*xbar^27 + 13*xbar^26 + 14*xbar^25 + 7*xbar^24 + 27*xbar^23 + 2*xbar^22 + 20*xbar^21 + 27*xbar^20 + 12*xbar^19 + 9*xbar^18 + 24*xbar^17 + 20*xbar^16 + xbar^15 + 16*xbar^14 + 23*xbar^13 + 6*xbar^12 + 13*xbar^11 + 28*xbar^10 + 27*xbar^9 + 9*xbar^8 + 6*xbar^7 + 14*xbar^6 + 10*xbar^5 + 19*xbar^4 + 11*xbar^3 + 2*xbar^2 + 9*xbar + 28


def calc_g_ord(g,group_ord):
    base_ord=factor(group_ord)
    ret = 1
    for p,i in base_ord:
        l=0
        r=i+1
        while l+1<r:
            mid = (l+r)//2
            if g**(int(group_ord//(p**(i-mid+1)))) == 1:
                r=mid
            else:
                l=mid
        assert g**(int(group_ord//(p**(i-l)))) == 1
        ret *= p**l
    return ret

ord_g = calc_g_ord(g,ord)
assert g**(ord_g) == 1
print(int(ord_g).bit_length(),factor(ord_g))

#code based on https://tex2e.github.io/blog/crypto/DLP
def bsgs(g, y, q=None,inverse=None):
    if q is None:
        q = g.base_ring().cardinality()
    m = int(q**0.5)+1
    table = {}
    gr = 1  
    inv = inverse if inverse else lambda x:x**(-1)
    for r in range(m):
        table[gr] = r
        gr = (gr * g) 
    try:
        gm = inv(g)**(m)  
    except:
        assert False
    ygqm = y               
    for q in range(m):
        if ygqm in table:   
            return q * m + table[ygqm]
        ygqm = ygqm * gm
    assert False

def pohlig_hellman(g, y, n,inverse=None):
    # return x s.t. g^x == y
    # n is order of g or the group
    crt_moduli = []
    crt_remain = []
    for qq, i in factor(n):
        print(qq,i)
        gg = g**((n)//qq)
        g0 = g**(n//(qq**i))
        inv_g0 = g0**(qq**i -1)
        assert gg**qq == 1
        h = y**(n//(qq**i))
        x=0
        for k in range(i):
            hk = (inv_g0**x*h)**(qq**(i-1-k))
            assert hk**(qq) == 1
            d = bsgs(gg, hk, q=qq,inverse=inverse)
            assert not d is None and gg**d == hk
            x = x + qq**k * d
            print(d,x)
        if not x is None and x > 1:
            crt_moduli.append(qq**i)
            crt_remain.append(x)
    x = crt(crt_remain, crt_moduli)
    return x

n = pohlig_hellman(g,y,ord_g,lambda x: x**(ord_g-1))
assert g**n==y

def int_to_bytes(integer):
    integer=int(integer)
    return integer.to_bytes((integer.bit_length() + 7) // 8, 'big')
print(int_to_bytes(n))
