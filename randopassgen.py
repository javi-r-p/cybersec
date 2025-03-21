# Random password generator
print("Random password generator")
print("---")
print("Please note that some systems may not support certain symbols.")
print("-----")
charNum = int(input("Number of characters: "))
useLetters = int(input("Use letters when generating the password? (0 / 1) "))
useNumbers = int(input("Use numbers when generating the password? (0 / 1) "))
useSymbols = int(input("Use symbols when generating the password? (0 / 1) "))
letters = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z']
numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
