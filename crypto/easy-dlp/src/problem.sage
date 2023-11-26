from secret import flag

assert len(flag) < 60

flag_num = int.from_bytes(flag,'big')

p = 2
q = 3
r = 5

R.<x> = IntegerModRing(p*q*r)['x']

f = x^194 + 12*x^193 + 28*x^192 + 18*x^191 + 17*x^190 + 27*x^189 + 2*x^188 + 19*x^187 + 27*x^185 + 11*x^184 + 2*x^183 + 26*x^182 + 17*x^181 + 5*x^179 + 5*x^178 + 16*x^177 + 6*x^176 + x^175 + 13*x^174 + 4*x^173 + 27*x^172 + 20*x^171 + 28*x^170 + 26*x^169 + 18*x^168 + 9*x^167 + 15*x^166 + 11*x^165 + 12*x^164 + 12*x^163 + 21*x^162 + 21*x^161 + 6*x^160 + 21*x^159 + 18*x^158 + 7*x^157 + 29*x^156 + x^155 + 2*x^154 + 13*x^153 + 24*x^152 + 13*x^151 + 24*x^150 + 27*x^149 + 9*x^148 + 20*x^147 + 4*x^146 + 26*x^145 + 29*x^144 + 3*x^143 + 19*x^142 + 19*x^141 + 3*x^140 + 5*x^139 + 11*x^138 + 2*x^137 + 19*x^136 + 4*x^135 + 13*x^134 + 23*x^133 + 22*x^132 + 12*x^131 + 23*x^130 + 12*x^129 + 27*x^127 + 24*x^126 + 18*x^125 + 8*x^124 + 22*x^123 + 4*x^122 + 11*x^121 + 18*x^120 + 14*x^119 + 13*x^118 + 22*x^117 + 20*x^116 + 17*x^115 + 23*x^114 + 24*x^113 + 11*x^112 + 27*x^111 + 29*x^110 + 10*x^109 + 17*x^108 + 29*x^107 + 3*x^106 + 27*x^105 + 3*x^104 + 25*x^103 + 9*x^102 + 29*x^101 + 9*x^100 + 17*x^99 + 18*x^98 + 28*x^97 + 27*x^96 + 14*x^95 + 5*x^94 + 13*x^93 + 3*x^92 + 7*x^91 + 8*x^90 + 23*x^89 + 19*x^88 + 6*x^87 + 28*x^86 + 11*x^84 + 27*x^83 + 15*x^82 + 26*x^81 + 16*x^80 + 3*x^79 + 26*x^78 + x^77 + 25*x^76 + 8*x^75 + 14*x^74 + 9*x^73 + x^72 + 8*x^71 + 14*x^70 + 18*x^69 + 23*x^68 + 19*x^67 + 2*x^66 + 26*x^65 + 13*x^63 + 8*x^62 + 9*x^61 + 4*x^60 + 25*x^59 + 10*x^58 + 4*x^57 + 15*x^56 + 12*x^55 + 10*x^54 + 8*x^53 + 4*x^52 + 4*x^51 + 10*x^50 + 3*x^49 + 15*x^48 + 2*x^47 + 15*x^46 + x^45 + 8*x^44 + 20*x^43 + 13*x^42 + 15*x^41 + 3*x^40 + 19*x^39 + 9*x^38 + 26*x^37 + 16*x^36 + 3*x^35 + 23*x^34 + 4*x^33 + 18*x^31 + 16*x^30 + 2*x^29 + 15*x^28 + 4*x^27 + 28*x^26 + 24*x^25 + 26*x^24 + 9*x^23 + 8*x^21 + 29*x^20 + 28*x^19 + 28*x^18 + 17*x^17 + 18*x^16 + 2*x^15 + 10*x^14 + 23*x^13 + 19*x^12 + 4*x^11 + x^10 + 6*x^9 + 19*x^8 + 3*x^7 + 25*x^6 + 3*x^5 + 17*x^4 + 10*x^3 + 20*x^2 + 8*x + 29

S = R.quo(f)

g = S(8*x^193 + 4*x^192 + 3*x^191 + 14*x^190 + 16*x^189 + 17*x^188 + 28*x^187 + 29*x^186 + 25*x^185 + 4*x^184 + 15*x^183 + 16*x^182 + 23*x^181 + 21*x^180 + 28*x^179 + 24*x^177 + 25*x^176 + 11*x^175 + 19*x^174 + 16*x^173 + 21*x^172 + 20*x^171 + x^170 + 21*x^169 + 25*x^168 + 2*x^167 + 11*x^166 + 9*x^165 + 22*x^164 + 13*x^163 + 6*x^162 + 25*x^160 + 13*x^159 + 8*x^158 + 5*x^157 + 19*x^156 + 7*x^155 + 8*x^154 + 12*x^153 + 23*x^152 + 24*x^151 + 24*x^150 + 18*x^149 + 9*x^148 + 29*x^147 + 23*x^146 + 7*x^145 + 14*x^144 + 21*x^143 + 29*x^142 + 3*x^141 + 8*x^139 + x^138 + 16*x^137 + 27*x^136 + 14*x^135 + 14*x^134 + 20*x^133 + 20*x^132 + 19*x^131 + 13*x^130 + 3*x^129 + 9*x^128 + 3*x^127 + 15*x^126 + 21*x^125 + 10*x^124 + 17*x^123 + 12*x^122 + 4*x^121 + 16*x^120 + 22*x^119 + 14*x^118 + 24*x^117 + 19*x^115 + 25*x^114 + 14*x^113 + 6*x^112 + 16*x^111 + 24*x^110 + 24*x^109 + x^108 + 17*x^106 + 16*x^105 + 20*x^104 + 6*x^103 + 28*x^102 + 29*x^101 + 6*x^100 + 24*x^99 + 15*x^98 + 25*x^97 + 17*x^96 + 16*x^95 + 2*x^94 + 22*x^93 + 20*x^92 + 13*x^91 + 15*x^90 + 3*x^89 + 4*x^88 + 15*x^87 + 8*x^86 + 7*x^85 + 16*x^84 + 28*x^83 + 4*x^81 + 18*x^80 + 26*x^79 + 10*x^78 + 7*x^77 + 21*x^76 + 23*x^75 + 6*x^74 + 22*x^73 + 25*x^72 + 16*x^71 + 20*x^70 + 15*x^69 + 16*x^68 + 28*x^67 + x^66 + 13*x^65 + 26*x^64 + 27*x^63 + 20*x^62 + 25*x^61 + x^60 + 3*x^59 + 16*x^58 + 16*x^57 + 17*x^55 + 23*x^54 + 11*x^53 + 10*x^52 + 22*x^51 + 18*x^50 + 2*x^49 + 28*x^48 + 19*x^47 + 28*x^46 + 5*x^45 + 13*x^44 + x^43 + 6*x^42 + 27*x^41 + 12*x^40 + 12*x^39 + x^38 + 19*x^37 + 13*x^36 + 10*x^35 + 14*x^34 + 2*x^33 + 27*x^32 + 9*x^31 + 27*x^30 + 9*x^29 + 28*x^28 + 28*x^27 + 14*x^26 + 25*x^25 + 23*x^24 + 24*x^23 + 21*x^22 + 29*x^21 + 16*x^20 + 5*x^19 + 15*x^18 + 9*x^17 + 28*x^16 + 18*x^15 + 2*x^14 + 17*x^13 + 14*x^12 + 24*x^11 + 10*x^10 + 2*x^9 + 21*x^8 + 9*x^7 + 27*x^6 + 21*x^5 + 19*x^4 + 14*x^3 + 11*x^2 + 23*x + 18)

print("g**flag_num=",g**flag_num)