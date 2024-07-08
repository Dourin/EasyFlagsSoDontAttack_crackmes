# Crackme Obfuscation Challenge

Ce projet est un programme de type "crackme" écrit en assembleur x64. Il demande à l'utilisateur de saisir un mot de passe et compare cette entrée avec un mot de passe encodé en héxadécimal dans le code. Si le mot de passe est correct, le programme affiche "Good Job!" et retourne 0. Sinon, il affiche "Bad Password!" et retourne 1.

## Description du code

Le mot de passe correct est 'M5JhvFvuJtfOQw7H', mais il est encodé dans la section `.data` et est comparé avec la chaîne de caractère saisie par l'utilisateur. Cela rend le mot de passe plus difficile à retrouver directement dans le binaire.

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

## Auteurs
Dorin MUNCIULEANU

Mustapha AIT BOULOUZE


