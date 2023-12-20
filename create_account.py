from random import choice, randint
from csv import reader
from os import system
from json import load, dump

first_names = reader(open("First_Name_DB.csv", 'r'))
first_names = list(first_names)

last_names = reader(open("Last_Name_DB.csv", 'r'))
last_names = list(last_names)

data = load(open('db.json', 'r'))

while True:

  first_name = choice(first_names)[0]
  last_name = choice(last_names)[0]
  birthday = str(randint(1, 12)) + "/" + str(randint(1, 28)) + "/" +  str(randint(2008, 2010))
  first_last_name = first_name + "." + last_name
  user_name = first_last_name.lower() + "." + str(randint(10000,99999))
  password = first_last_name.lower() + "." + str(randint(10000,99999))

  system('cls')
  print()
  print('Numero de cuentas:', len(data['accounts']))
  print('First Name:', "\t", first_name)
  print('Last Name:', "\t", last_name)
  print('Birthday:', "\t", birthday)
  print('User Name:', "\t", user_name)
  print('Password:', "\t", password)
  print()

  dictionary = {
    "first_name": first_name,
    "last_name": last_name,
    "birthday": birthday,
    "user_name": user_name,
    "password": password
  }

  data['accounts'].append(dictionary)

  input('> ')
  dump(data, open('db.json', 'w'))


