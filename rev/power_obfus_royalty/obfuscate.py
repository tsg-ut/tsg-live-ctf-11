import string, re, random, os, base64
file_dir = os.path.dirname(os.path.abspath(__file__))
path_init = file_dir + '/init.ps1'
path_rand_alpha = file_dir + '/rand_alpha.ps1'
path_obfus_rand_alpha = file_dir + '/obfus_rand_alpha.ps1'
path_first_base64 = file_dir + '/first_base64.ps1'

NEVER = [r"TSGLIVE{1nv0k3_3xpr35510n_15_an_1mp0r7an7_f3a7ur3_f0r_p0w3r5h3ll_0bfu5ca710n}", r"Correct!!!", r"Wrong...", "FLAG"]

def str_obfus(line):
    new_line = ''
    for i in line:
        new_line += "[char]"+str(ord(i))+"+"
    line = '(' + new_line[:-1] + ')'
    return line

def rand_alpha(line):
    for i in NEVER:
        if (re.findall(i, line)):
            new_list = []
            for j in line.split("'" + i + "'"):
                new_list.append(rand_alpha(j))
            i = rand_alpha(str_obfus(i))
            line = i.join(new_list)
            return line
        
    new_line = ''
    for i in line:
        if (i.isalpha()):
            if (random.randint(0, 1)):
                new_line += i.upper()
            else:
                new_line += i.lower()
        else:
            new_line += i
    line = new_line
    return line

def base64_enc(line):
    file = re.sub(r'`', r'``', line)
    file = re.sub(r'"', r'`"', file)
    file = re.sub(r'\$', r'`$', file)
    file = "\"" + file + "\""
    file = rand_alpha(str_obfus(file))
    file = "iex (iex " + file + ")"
    file = base64.b64encode(file.encode('utf-16-le')).decode()
    NEVER.append(file)
    return ("powershell.exe -executionpolicy bypass -enc " + file)


bf_path = path_init
af_path = path_rand_alpha
bf = open(bf_path)
af = open(af_path, mode='w')
for line in bf:
    af.write(rand_alpha(line))

bf_path = path_rand_alpha
af_path = path_obfus_rand_alpha
bf = open(bf_path)
af = open(af_path, mode='w')
cnt = 0
for line in bf:
    result = re.findall(r"\"[^\"]*\"", line)
    for i in result:
        cnt += 1
        old = i
        if (cnt == 4):
            i = i[1:-1]
            div1 = len(i) // 3
            div2 = len(i) // 3 * 2
            f_i = i[:div1]
            s_i = i[div1:div2]
            s_i = base64_enc("echo " + s_i)
            l_i = i[div2:]
            i = "(iex (\"" + f_i + "\"+(" + s_i + ")+\"" + l_i + "\"))"
        line = line.replace(old, i)
        line = (line.replace(i, rand_alpha(str_obfus(i[1:-1]))))
    af.write(line)