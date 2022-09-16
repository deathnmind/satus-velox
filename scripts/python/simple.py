import random

def genNames(fileName): 
    with open(fileName, "r") as namesFile:
        names = [line.strip() for line in namesFile] # load names from file
    while True:               # repeat indefinitely
        random.shuffle(names) # randomize order
        yield from names      # yield all names

def genFullNames(gen_number):
    i = 0
    iAlienNames = genNames("list.txt") # infinite random alien names
    iSuffixes   = genNames("list.txt")      # infinite random suffixes
    seen = set()                              # track uniques
    while True:
        if i > gen_number:
            break
        elif i < gen_number:
            i = i + 1
            fullName = (next(iAlienNames), next(iSuffixes)) # pair up names
            if fullName in seen: continue # never yield same pairing twice
            yield fullName                # return one name when next() is called
            seen.add(fullName)            # remember using that pairing


def looper(gen_number):
    iFullName = genFullNames(gen_number)  # infinite full name pair iterator
    for _ in range(gen_number):
        try:
            aName, sName = next(iFullName)
            while True:
                if aName == sName:
                    aName, sName = next(iFullName)
                elif aName != sName:
                     break
            print(aName, sName)
        except:
            break
          
def main():
    while True:
        try:
            gen_number = int(input('How many random names do you want generated: '))
        except ValueError:
            print("The input is not a valid integer.")
            continue
        else:
            break
    looper(gen_number)

if __name__ == "__main__":
    main()
