header = """DEPTH = 262144;
WIDTH = 32;
ADDRESS_RADIX = HEX;
DATA_RADIX = HEX;
CONTENT
BEGIN\n"""
end = "END;\n"

if __name__ == '__main__':
    i=0
    file = open("de1_data.mif", "w")
    file.write(header)
    with open("hexa.txt", "r") as ins:
        for line in ins:
            lines = line.rstrip('\n')
            a = '{:08x}'.format(i)
            file.write(a + " : " + lines + ";\n")
            i = i + 1
    file.write(end)

   
