# Crackme Obfuscation Challenge

Ce projet est un programme de type "crackme" écrit en assembleur x64. Il demande à l'utilisateur de saisir un mot de passe et compare cette entrée avec un mot de passe encodé de manière obfusquée dans le code. Si le mot de passe est correct, le programme affiche "Good Job!" et retourne 0. Sinon, il affiche "Bad Password!" et retourne 1.

## Description du code

Le mot de passe correct est 'GOODPASSWORD1235', mais il est encodé dans la section `.data` et est décodé lors de l'exécution en utilisant une opération XOR avec une clé de 0x55. Cela rend le mot de passe plus difficile à retrouver directement dans le binaire.

### Sections du code

- **.data** : Contient le mot de passe encodé et les messages à afficher.
- **.bss** : Contient le buffer pour l'entrée utilisateur et le mot de passe décodé.
- **.text** : Contient le code d'exécution principal, y compris la logique de comparaison et de décodage du mot de passe.

### Instructions de compilation et d'exécution

1. Écrire le code assembleur dans un fichier `test.asm`.
2. Utiliser `nasm` pour assembler le fichier source en un fichier objet :
    ```sh
    nasm -f elf64 -o crackme.o test.asm
    ```
3. Utiliser `ld` pour lier le fichier objet et créer l'exécutable :
    ```sh
    ld -o crackme crackme.o
    ```
4. Exécuter le programme :
    ```sh
    ./crackme
    ```

## Exemples d'exécution

Voici quelques exemples montrant l'exécution du programme avec différentes entrées :

```sh
debian@debian ~/crackme »                                                                                130 ↵
debian@debian ~/crackme » echo "GOODPASSWORD1235" | ./crackme ; echo $?                                  130 ↵
echo "BADPASSWORD12345" | ./crackme ; echo $?
echo "GOODPASSWORD12341" | ./crackme ; echo $?

Enter password:Good Job!0
Enter password:Bad Password!
1
Enter password:Bad Password!
1
```

## Auteurs
Dorin MUNCIULEANU

Mustapha AIT BOULOUZE


