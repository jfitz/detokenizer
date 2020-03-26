/*
Dump tokenized MBASIC-80 program
*/
package main

import (
	//  "bytes"
	//	"encoding/binary"
	"flag"
	"fmt"
	"io/ioutil"
	"os"
)

func dumpAscii(line_number int, data []byte, table map[int]string, table2 map[int]string, prefix byte) int {
	fmt.Printf("%d ", line_number)

	count := 0
	done := false
	dim_seen := false

	for !done {
		b := data[count]
		b16 := int(b)

		if b16 == 0x86 {
			dim_seen = true
		}

		// 0x0F - 1-byte integer
		if b == 0x0F {
			i := int(data[count+1])

			fmt.Printf("%d", i)

			count += 1
		}

		// 0x0E - 2-byte integer
		if b == 0x0E {
			i := int(data[count+2])*256 + int(data[count+1])

			fmt.Printf("%d", i)

			count += 2
		}

		// 0x0C - 2-byte integer
		if b == 0x0C {
			i := int(data[count+2])*256 + int(data[count+1])

			fmt.Printf("%d", i)

			count += 2
		}

		// 0x1C - 2-byte integer rendered in hexadecimal
		if b == 0x1C {
			i := int(data[count+2])*256 + int(data[count+1])

			fmt.Printf("&%04X", i)

			count += 2
		}

		// 0x1D and 0x1F - 4-byte float
		if b == 0x1D || b == 0x1F {
			bs := data[count+1 : count+5]
			fmt.Printf("[%02X]", b)
			fmt.Printf("%02X", bs)
			// var v float32
			// buf := bytes.NewReader(bs)
			// err := binary.Read(buf, binary.LittleEndian, &v)
			// if err == nil {
			// 	fmt.Printf("%f", v)
			// } else {
			// 	fmt.Print("bad float")
			// }

			count += 4
		}

		// 0xFF - 2-byte token
		if b == 0xFF {
			code := int(data[count+1])

			if s, ok := table2[code]; ok {
				fmt.Print(s)
			} else {
				fmt.Printf("[0xFF][%02X]", code)
			}

			count += 1
		}

		// 0x80 to 0xFE - 1-byte token
		if b16 >= 0x80 && b16 <= 0xFE {
			if s, ok := table[b16]; ok {
				fmt.Print(s)
			} else {
				fmt.Printf("[%02X]", b16)
			}
		}

		// 0x32 to 0x7F - plain character
		if b >= 0x20 && b <= 0x7F {
			fmt.Printf("%c", b16)
		}

		// 0x01 to 0x31 - certain tokens or a 1-byte integer
		if b > 0 && b < 0x20 {
			handled := false

			if b == 0x09 {
				// TAB
				fmt.Print("\\t")

				handled = true
			}

			if b == 0x0A {
				// LF
				fmt.Print("\\n")

				handled = true
			}

			if b == 0x0D {
				// CR
				fmt.Print("\\r")

				handled = true
			}

			if b == 0x0E || b == 0x0F || b == 0x0C || b == 0x1C || b == 0x1D || b == 0x1F {
				// do nothing (already handled above)
				handled = true
			}

			if !handled {
				if dim_seen {
					// on DIM line
					// convert to ASCII decimal
					fmt.Printf("%d", b16)
				} else {
					// on other lines
					// convert to escaped hex
					fmt.Printf("0x%02X", b16)
				}
			}
		}

		// byte of zero is end of line
		if b16 == 0 {
			done = true
		}

		count += 1
	}

	return count
}

func main() {
	include_bytes_ptr := flag.Bool("hex", false, "Include hex bytes")

	flag.Parse()
	args := flag.Args()

	if len(args) == 0 {
		fmt.Println("No file specified")
		os.Exit(1)
	}

	include_bytes := *include_bytes_ptr

	// get file name
	fileName := args[0]

	data, _ := ioutil.ReadFile(fileName)

	// build decode tables
	table := map[int]string{}

	table[0x81] = "END"
	table[0x82] = "FOR"
	table[0x83] = "NEXT"
	table[0x84] = "DATA"
	table[0x85] = "INPUT"
	table[0x86] = "DIM"
	table[0x87] = "READ"
	table[0x88] = "LET"
	table[0x89] = "GOTO"
	table[0x8A] = "RUN"
	table[0x8B] = "IF"
	table[0x8C] = "RESTORE"
	table[0x8D] = "GOSUB"
	table[0x8E] = "RETURN"
	table[0x8F] = "REM"
	table[0x90] = "STOP"
	table[0x91] = "PRINT"
	table[0x92] = "CLEAR"
	table[0x93] = "LIST"
	table[0x94] = "NEW"
	table[0x95] = "ON"
	table[0x96] = "DEF"
	table[0x97] = "POKE"
	table[0x9B] = "LPRINT"
	table[0x9C] = "LLIST"
	table[0x9D] = "SWAP"
	table[0x9E] = "ELSE"
	table[0x9F] = "TRACE"
	table[0xA0] = "NOTRACE"
	table[0xA1] = "WIDTH"
	table[0xA2] = "ELSE"
	table[0xA3] = "EDIT"
	table[0xA4] = "ERROR"
	table[0xA5] = "RESUME"
	table[0xA6] = "DEL"
	table[0xA7] = "AUTO"
	table[0xA8] = "ERROR"
	table[0xA9] = "STOP"
	table[0xAA] = "POP"
	table[0xAB] = "DEFSNG"
	table[0xAC] = "DEFDBL"
	table[0xAD] = "LINE"
	table[0xAE] = "DEFINT"
	table[0xAF] = "WHILE"
	table[0xB0] = "WEND"
	table[0xB1] = "CALL"
	table[0xB2] = "WRITE"
	table[0xB3] = "COMMON"
	table[0xB4] = "CHAIN"
	table[0xB5] = "OPTION"
	table[0xB6] = "RANDOMIZE"
	table[0xB7] = "SYSTEM"
	table[0xB8] = "OPEN"
	table[0xB9] = "FIELD"
	table[0xBA] = "GET"
	table[0xBB] = "PUT"
	table[0xBC] = "CLOSE"
	table[0xBD] = "LOAD"
	table[0xBE] = "MERGE"
	table[0xBF] = "OPEN"
	table[0xC0] = "NAME"
	table[0xC1] = "KILL"
	table[0xC2] = "LSET"
	table[0xC3] = "CLOSE"
	table[0xC4] = "SAVE"
	table[0xC5] = "RESET"
	table[0xC8] = "VTAB"
	table[0xC9] = "HTAB"
	table[0xCE] = "TO"
	table[0xCF] = "THEN"
	table[0xD0] = "TAB("
	table[0xD1] = "STEP"
	table[0xD3] = ""
	table[0xD4] = "BEEP"
	table[0xD5] = "WAIT"
	table[0xD6] = "ERL"
	table[0xD7] = "ERR"
	table[0xD8] = "STRING$"
	table[0xD9] = "USING"
	table[0xDB] = " "
	table[0xE0] = "STEP"
	table[0xE1] = "USR"
	table[0xE2] = "FN"
	table[0xE3] = "SPC("
	table[0xE4] = "NOT"
	table[0xE5] = "ERL"
	table[0xE6] = "RENUM"
	table[0xE7] = "STRING$"
	table[0xE8] = "USING"
	table[0xE9] = "INSTR"
	table[0xEB] = "VARPTR"
	table[0xEE] = "INKEY$"
	table[0xEF] = ">"
	table[0xF0] = "="
	table[0xF1] = "<"
	table[0xF2] = "+"
	table[0xF3] = "-"
	table[0xF4] = "*"
	table[0xF5] = "/"
	table[0xF6] = "^"
	table[0xF7] = "AND"
	table[0xF8] = "OR"
	table[0xF9] = "XOR"
	table[0xFA] = "EQV"
	table[0xFB] = "IMP"
	table[0xFD] = "MOD"
	table[0xFF] = ""

	table2 := map[int]string{}

	table2[0x81] = "LEFT$"
	table2[0x82] = "RIGHT$"
	table2[0x83] = "MID$"
	table2[0x84] = "SGN"
	table2[0x85] = "INT"
	table2[0x87] = "SQR"
	table2[0x88] = "RND"
	table2[0x89] = "SIN"
	table2[0x8A] = "LOG"
	table2[0x8B] = "EXP"
	table2[0x8C] = "COS"
	table2[0x8D] = "TAN"
	table2[0x8E] = "ATN"
	table2[0x8F] = "PEEK"
	table2[0x90] = "POS"
	table2[0x91] = "LEN"
	table2[0x92] = "STR$"
	table2[0x93] = "VAL"
	table2[0x94] = "FRE"
	table2[0x95] = "ASC"
	table2[0x96] = "CHR$"
	table2[0x97] = "SPACE$"
	table2[0x98] = "OCT$"
	table2[0x99] = "HEX$"
	table2[0x9A] = "LPOS"
	table2[0x9B] = "CINT"
	table2[0x9C] = "CSNG"
	table2[0x9D] = "CDBL"
	table2[0x9E] = "FIX"
	table2[0xAA] = "CVI"
	table2[0xAB] = "CVS"
	table2[0xAC] = "CVD"
	table2[0xAE] = "EOF"
	table2[0xAF] = "LOC"
	table2[0xB0] = "LOF"
	table2[0xB1] = "MKI$"
	table2[0xB2] = "MKS$"
	table2[0xB3] = "MKD$"
	table2[0xB4] = "VPOS"

	contents := data[1:]

	// for all bytes
	done := false

	for !done {
		// 2 bytes for line number
		line_number := int(contents[3])*256 + int(contents[2])

		if line_number == 0 {
			done = true
		} else {
			payload := contents[4:]

			// print the untokenized line
			count := dumpAscii(line_number, payload, table, table2, 0xff)
			fmt.Println()

			if include_bytes {
				// dump bytes (including NULL) as hex and ascii
				line_count := count + 4
				line := contents[:line_count]
				fmt.Printf("% 02X", line)
				fmt.Println()

				fmt.Println()
			}

			contents = payload[count:]

			if len(contents) < 5 {
				done = true
			}
		}
	}
}
