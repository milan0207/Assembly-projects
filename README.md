# Program Specification

## Project Overview

During the inaugural semester (2022) of my Software Engineering studies, I undertook the challenge of crafting this project in the stimulating environment of the Computer Architecture class.
## ionum.asm

### ReadInt():(EAX)
- Reads a 32-bit signed integer.

### WriteInt(EAX):()
- Writes a 32-bit signed integer.

### ReadInt64():(EDX:EAX)
- Reads a 64-bit signed integer.

### WriteInt64(EDX:EAX):()
- Writes a 64-bit signed integer.

### ReadBin():(EAX)
- Reads a 32-bit positive binary integer.

### WriteBin(EAX):()
- Writes a 32-bit positive binary integer.

### ReadBin64():(EDX:EAX)
- Reads a 64-bit positive binary integer.

### WriteBin64(EDX:EAX):()
- Writes a 64-bit positive binary integer.

### ReadHex():(EAX)
- Reads a 32-bit positive hexadecimal integer.

### WriteHex(EAX):()
- Writes a 32-bit positive hexadecimal integer.

### ReadHex64():(EDX:EAX)
- Reads a 64-bit positive hexadecimal integer.

### WriteHex64(EDX:EAX):()
- Writes a 64-bit positive hexadecimal integer.

## iopelda.asm

- Tests the "ionum.asm" program.

### Functionality
- Reads a signed 32-bit integer in base-10.
- Writes the read value in base-10 as a signed integer, its representation in two's complement in base-16 and binary.
- Reads a 32-bit hexadecimal number.
- Writes the read value in base-10 as a signed integer, its representation in two's complement in base-16 and binary.
- Reads a 32-bit binary number.
- Writes the read value in base-10 as a signed integer, its representation in two's complement in base-16 and binary.
- Writes the sum of the three read values in base-10 as a signed integer, its representation in two's complement in base-16 and binary.
- Performs the above steps for 64-bit values as well.

## iostr.asm

### ReadStr(EDI or ESI, max length ECX):()
- C-style (null-terminated binary) string input procedure, reads until <Enter>.

### WriteStr(ESI):()
- String output procedure.

### ReadLnStr(EDI or ESI, ECX):()
- Similar to ReadStr() but also moves to a new line.

### WriteLnStr(ESI):()
- Similar to WriteStr() but also moves to a new line.

### NewLine():()
- Moves the cursor to the beginning of a new line.

## strings.asm

### StrLen(ESI):(EAX)
- Returns the length of the string pointed to by ESI in EAX, excluding the binary 0.

### StrCat(EDI, ESI):()
- Concatenates the strings pointed to by ESI and EDI (copies ESI after EDI).

### StrUpper(ESI):()
- Converts the string pointed to by ESI to uppercase.

### StrLower(ESI):()
- Converts the string pointed to by ESI to lowercase.

### StrCompact(ESI, EDI):()
- Copies the string pointed to by ESI to EDI, excluding space, tab (9), carriage return (13), and line feed (10) characters.

## strpelda.asm

### Functionality
- After printing the appropriate message, read a string.
- Print its length.
- Print its compact form.
- Print its compact form converted to lowercase.
- After printing the appropriate message, read a second string.
- Print its length.
- Print its compact form.
- Print its compact form converted to uppercase.
- Create a new string in memory: concatenate the uppercase version of the first string with the lowercase version of the second string.
- Print the created string.
- Print the length of the created string.
- Finish the program.
