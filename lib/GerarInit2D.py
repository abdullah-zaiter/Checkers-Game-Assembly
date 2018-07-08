
Xs = [20, 70, 120 ,170,
      45, 95, 145, 195, 
      20, 70, 120, 170,
      45, 95, 145, 195,
      20, 70, 120, 170,
      45, 95, 145, 195,
      20, 70, 120, 170,
      45, 95, 145, 195,

      ]

Ys = [20, 20, 20, 20,
      45, 45, 45, 45,
      70, 70, 70, 70,
      95, 95, 95, 95,
      120, 120, 120, 120,
      145, 145,145 ,145,
      170, 170, 170, 170,
      195, 195, 195, 195
      ]

Name = [
        "B1", "D1", "F1", "H1",
        "A2", "C2", "E2", "G2",
        "B3", "D3", "F3", "H3",
        "A4", "C4", "E4", "G4",
        "B5", "D5", "F5", "H5",
        "A6", "C6", "E6", "G6",
        "B7", "D7", "F7", "H7",
        "A8", "C8", "E8", "G8"
        ]

AddressMemStack = 0xff200000
AddressMemVector = [0x00000700, 0x00000720, 0x00000740, 0x00000760,
                    0x00000610, 0x00000630, 0x00000650, 0x00000670,
                    0x00000500, 0x00000520, 0x00000540, 0x00000560,
                    0x00000410, 0x00000430, 0x00000450, 0x00000470,
                    0x00000300, 0x00000320, 0x00000340, 0x00000360,
                    0x00000210, 0x00000230, 0x00000250, 0x00000270,
                    0x00000100, 0x00000120, 0x00000140, 0x00000160,
                    0x00000010, 0x00000030, 0x00000050, 0x00000070]


def fileWrite(g, p,address, i):
    if (i == 0):
        file.write(".eqv AddressBegin 0xff200000" + "\n\n")
    file.write(".eqv " + Name[i] + " " + g + "\n")
    file.write(".eqv " + "piece" + Name[i] + " " + p + "\n")
    file.write(".eqv " + "Address" + Name[i] + " " + address + "\n")

def fileWrite2(g, address, i):
    if(i == 0):
        file2.write("add t1, a1, zero" + "\n")######################
    elif ((i < 12) or (i>19)):
        file2.write("li a1, " + Name[i] + "\n")
        file2.write("li t2," + "Address" + Name[i] + "\n")
        file2.write("sw t0, 0(t2)" + "\n")
        file2.write("PrintCerto" + "\n\n")
        #print(Name[i])
    elif(i == 19):
        file2.write("la t0, blue" + "\n" +
                    "bne t1, t0, RED" + "\n"
                    "BLUE:" + "\n"
                    "   la t1, red" + "\n"
                    "   j CONTINUE" + "\n"
                    "RED:" + "\n"
                    "   la t1, blue" + "\n"+
	                "CONTINUE:" + "\n")
    else:
        file2.write("li t0, " + Name[i] + "\n")
        file2.write("li t2," + "Address" + Name[i] + "\n")
        file2.write("sw t0, 0(t2)" + "\n")
    #print (str(i) + "\n\n\n")

def main():
    for i in range (len(Xs)):
        x = Xs[i]
        y = Ys[i]
        f = int(x)+(320*int(y))+4278190080#0xff000000
        p = int(x+5)+(320*int(y+5))+4278190080#0xff000000
        #print(f)
        f = hex(f)
        p = hex(p)
        #print(f)
        a = AddressMemStack + AddressMemVector[i]
        a = hex(a)
        fileWrite(f, p, a, i)
        #fileWrite2(f, a, i)
        

if __name__ == '__main__':

    file = open("mapping2D.s", "w")
    file2 = open("init2DMapeamento.s", "w")

    main()

    file2.close()
    file.close()

