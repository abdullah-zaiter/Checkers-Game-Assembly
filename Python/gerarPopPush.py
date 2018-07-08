def popAll(j):
    if (j == 31):
        file.write("popAll:" + "\n\n")
        file.write("\tlw "+"x"+str(j)+", 0(sp) \n")
        file.write("\taddi sp, sp, 4\n")
        file.write("\n")
    elif (j!= 0):
        file.write("\tlw "+"x"+str(j)+", 0(sp) \n")
        file.write("\taddi sp, sp, 4\n")
        file.write("\n")
    if(j == 0):
        file.write("\tjr ra \n\n")


def pushAll(i):
    if (i == 0):
        file.write("pushAll:" + "\n\n")
    elif(i!=1):
        file.write("\taddi sp, sp, -4 \n")
        file.write("\tsw "+"x"+str(i) + ", 0(sp)\n")
        file.write("\n")
    if(i == 31):
        file.write("\tjr ra \n\n")


def pushFunct(i):
    if (i == 10):
        file.write("pushFunct:" + "\n\n")
    file.write("\taddi sp, sp, -4 \n")
    file.write("\tsw "+"x"+str(i) + ", 0(sp)\n")
    file.write("\n")
    if(i == 17):
        file.write("\tjr ra \n\n")


def popFunct(i):
    if (i == 17):
        file.write("popFunct:" + "\n\n")
    file.write("\tlw x"+str(i)+", 0(sp)\n")
    file.write("\taddi sp, sp,4\n")
    file.write("\n")
    if(i == 10):
        file.write("\tlw ra, 0(sp)\n")
        file.write("\taddi sp, sp,4\n")
        file.write("\n")
        file.write("\tjr ra \n\n")


def printHowTo():
    file.write("####### COMO USAR:\n"
               +"#\t\taddi sp, sp, -4\n"
               +"#\t\tsw ra, 0(sp)\n"
               +"#\t\tjal pushAll\n"
               +"#\n"
               +"#\t\tblablabl:\n"
               +"#\t\t\tdasdasdasdasdsa\n"
               +"#\t\t\tdasdasdasdasdsadas\n"
               +"#\t\t\tjal popAll\n\n\n")

def main():
    printHowTo()
    for i in range (0,32):
        pushAll(i)
    for i in range(0, 32):
        j = 31 - i
        popAll(j)
    for i in range(10,18):
        pushFunct(i)
    for i in range(10,18):
        j = 27-i
        popFunct(j)





if __name__ == '__main__':

    file = open("pushPop.s", "w")
    main()
    file.close()
