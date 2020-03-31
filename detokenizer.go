/*
Dump tokenized MBASIC-80 program
*/
package main

import (
	"flag"
	"fmt"
	"io/ioutil"
	"os"
)

func twoNegPower32(exponent int) float32 {
	value := float32(2.0)
	f := float32(1.0)

	if exponent == 0 {
		return f
	}

	for exponent > 0 {
		f = value * f
		exponent -= 1
	}
	f = 1 / f

	return f
}

func twoNegPower64(exponent int) float64 {
	value := float64(2.0)
	f := float64(1.0)

	if exponent == 0 {
		return f
	}

	for exponent > 0 {
		f = value * f
		exponent -= 1
	}
	f = 1 / f

	return f
}

func dumpAscii(line_number int, data []byte, table map[int]string, table2 map[int]string, prefix byte) int {
	fmt.Printf("%d ", line_number)

	count := 0
	done := false

	for !done {
		b := data[count]
		b16 := int(b)

		handled := false

		// 0x0F - 1-byte integer as decimal
		if b == 0x0F {
			i := int(data[count+1])

			fmt.Printf("%d", i)

			count += 1
			handled = true
		}

		// 0x0E - 2-byte integer as decimal
		if b == 0x0E {
			i := int(data[count+2])*256 + int(data[count+1])

			fmt.Printf("%d", i)

			count += 2
			handled = true
		}

		// 0x0C - 2-byte integer as hexadecimal
		if b == 0x0C {
			i := int(data[count+2])*256 + int(data[count+1])

			fmt.Printf("&H%02X", i)

			count += 2
			handled = true
		}

		// 0x0B - 2-byte integer as octal
		if b == 0x0B {
			i := int(data[count+2])*256 + int(data[count+1])

			fmt.Printf("&O%03o", i)

			count += 2
			handled = true
		}

		// 0x1C - 2-byte integer as decimal
		// why duplicate 0x0E? Is something different?
		if b == 0x1C {
			i := int(data[count+2])*256 + int(data[count+1])

			fmt.Printf("%d", i)

			count += 2
			handled = true
		}

		// 0x1D - 4-byte float as decimal
		if b == 0x1D {
			bt1 := int(data[count+1])
			bt2 := int(data[count+2])
			bt3 := int(data[count+3])
			bt4 := int(data[count+4])

			f1a := float32(bt1) * twoNegPower32(23)
			f1b := float32(bt2) * twoNegPower32(15)
			f1c := float32(bt3) * twoNegPower32(7)
			f1 := f1a + f1b + f1c + float32(1.0)
			f2 := twoNegPower32(129 - bt4)
			f := f1 * f2

			fmt.Printf("%g", f)

			count += 4
			handled = true
		}

		// 0x1F - 8-byte float as decimal
		if b == 0x1F {
			bt1 := int(data[count+1])
			bt2 := int(data[count+2])
			bt3 := int(data[count+3])
			bt4 := int(data[count+4])
			bt5 := int(data[count+5])
			bt6 := int(data[count+6])
			bt7 := int(data[count+7])
			bt8 := int(data[count+8])

			f1a := float64(bt1) * twoNegPower64(55)
			f1b := float64(bt2) * twoNegPower64(47)
			f1c := float64(bt3) * twoNegPower64(39)
			f1d := float64(bt4) * twoNegPower64(31)
			f1e := float64(bt5) * twoNegPower64(23)
			f1f := float64(bt6) * twoNegPower64(15)
			f1g := float64(bt7) * twoNegPower64(7)
			f1 := f1a + f1b + f1c + f1d + f1e + f1f + f1g + 1.0
			f2 := twoNegPower64(129 - bt8)
			f := f1 * f2

			fmt.Printf("%g", f)

			count += 8
			handled = true
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
			handled = true
		}

		// 0x80 to 0xFE - 1-byte token
		if b16 >= 0x80 && b16 <= 0xFE {
			if s, ok := table[b16]; ok {
				fmt.Print(s)
			} else {
				fmt.Printf("[%02X]", b16)
			}

			handled = true
		}

		// 0x32 to 0x7F - plain character
		if b >= 0x20 && b <= 0x7F {
			fmt.Printf("%c", b16)

			handled = true
		}

		// byte of zero is end of line
		if b16 == 0 {
			done = true

			handled = true
		}

		// 0x01 to 0x31 - certain tokens or a 1-byte integer
		if b == 0x07 {
			// BEL
			fmt.Print("\\a")

			handled = true
		}

		if b == 0x08 {
			// BS
			fmt.Print("\\b")

			handled = true
		}

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

		if !handled {
			if b16 >= 0x11 {
				// 1-byte numeric as decimal
				n := b16 - 0x11
				fmt.Printf("%d", n)
			} else {
				// 1-byte ASCII control character
				fmt.Printf("0x%02X", b16)
			}
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

	// need BASE

	table[0x81] = "END"       // 8K
	table[0x82] = "FOR"       // 8K
	table[0x83] = "NEXT"      // 8K
	table[0x84] = "DATA"      // 8K
	table[0x85] = "INPUT"     // 8K
	table[0x86] = "DIM"       // 8K
	table[0x87] = "READ"      // 8K
	table[0x88] = "LET"       // 8K
	table[0x89] = "GOTO"      // 8K
	table[0x8A] = "RUN"       // ? 8K
	table[0x8B] = "IF"        // 8K
	table[0x8C] = "RESTORE"   // 8K
	table[0x8D] = "GOSUB"     // 8K
	table[0x8E] = "RETURN"    // 8K
	table[0x8F] = "REM"       // 8K
	table[0x90] = "STOP"      // 8K
	table[0x91] = "PRINT"     // 8K
	table[0x92] = "CLEAR"     // 8K
	table[0x93] = "LIST"      // ? 8K
	table[0x94] = "NEW"       // ? 8K
	table[0x95] = "ON"        // 8K
	table[0x96] = "NULL"      // 8K
	table[0x97] = "WAIT"      // 8K
	table[0x98] = "DEF"       // 8K
	table[0x99] = "POKE"      // 8K
	table[0x9A] = "CONT"      // 8K
	table[0x9B] = "LPRINT"    // Ext
	table[0x9D] = "OUT"       // 8K
	table[0x9F] = "LLIST"     // ? Ext
	table[0xA0] = "NOTRACE"   // is this a command
	table[0xA1] = "WIDTH"     // Ext
	table[0xA2] = "ELSE"      // Ext
	table[0xA3] = "TRON"      // Ext
	table[0xA4] = "TROFF"     // Ext
	table[0xA5] = "SWAP"      // Ext
	table[0xA6] = "ERASE"     // Ext
	table[0xA7] = "EDIT"      // ? Ext
	table[0xA8] = "ERROR"     // Ext
	table[0xA9] = "RESUME"    // Ext
	table[0xAA] = "DELETE"    // Ext
	table[0xAB] = "AUTO"      // ? Ext
	table[0xAC] = "RENUM"     // ? Ext
	table[0xAD] = "DEFSTR"    // Ext
	table[0xAE] = "DEFINT"    // Ext
	table[0xAF] = "DEFSNG"    // Ext
	table[0xB0] = "DEFDBL"    // Ext
	table[0xB1] = "LINE"      // Ext
	table[0xB2] = "WRITE"     // Disk one is wrong
	table[0xB3] = "COMMON"    // Disk one is wrong
	table[0xB4] = "WHILE"     // Ext
	table[0xB5] = "WEND"      // Ext
	table[0xB6] = "CALL"      // Ext
	table[0xB7] = "WRITE"     // Disk one is wrong
	table[0xB8] = "COMMON"    // Disk one is wrong
	table[0xB9] = "CHAIN"     // Disk
	table[0xBA] = "OPTION"    // 8K
	table[0xBB] = "RANDOMIZE" // Ext
	//	table[0xBC] = "CLOSE"     // Disk one is wrong
	table[0xBD] = "SYSTEM"  // is this a command
	table[0xBE] = "MERGE"   // Disk one is wrong
	table[0xBF] = "OPEN"    // Disk
	table[0xC0] = "FIELD"   // Disk
	table[0xC1] = "GET"     // Disk
	table[0xC2] = "PUT"     // Disk
	table[0xC3] = "CLOSE"   // Disk
	table[0xC4] = "LOAD"    // ? Disk
	table[0xC5] = "MERGE"   // Disk one is wrong
	table[0xC6] = "FILES"   // Disk
	table[0xC7] = "NAME"    // Disk
	table[0xC8] = "KILL"    // Disk
	table[0xC9] = "LSET"    // Disk
	table[0xCA] = "RSET"    // Disk
	table[0xCB] = "SAVE"    // ? Disk
	table[0xCC] = "RESET"   // is this a command?
	table[0xCE] = "TO"      // 8K
	table[0xCF] = "THEN"    // 8K
	table[0xD0] = "TAB("    // 8K
	table[0xD1] = "STEP"    // 8K
	table[0xD2] = "USR"     // 8K
	table[0xD3] = "FN"      // 8K
	table[0xD4] = "SPC("    // 8K
	table[0xD5] = "NOT"     // 8K
	table[0xD6] = "ERL"     // Ext
	table[0xD7] = "ERR"     // Ext
	table[0xD8] = "STRING$" // Ext
	table[0xD9] = "USING"   // Ext
	table[0xDA] = "INSTR"   // Ext
	table[0xDB] = "ARK "    // Ext
	table[0xDC] = "VARPTR"  // Ext
	table[0xDD] = "INKEY$"  // Ext
	// table[0xE0] = "STEP"    // 8K one is wrong
	// table[0xE1] = "USR"     // 8K one is wrong
	// table[0xE2] = "FN"      // 8K one is wrong
	// table[0xE3] = "SPC("    // 8K one is wrong
	// table[0xE4] = "NOT"     // 8K one is wrong
	// table[0xE5] = "ERL"     // Ext one is wrong
	///table[0xE6] = "RENUM"   // ? Ext
	///table[0xE7] = "STRING$" // Ext one is wrong
	///table[0xE8] = "USING"   // Ext one is wrong
	///table[0xE9] = "INSTR"   // Ext one is wrong
	///table[0xEB] = "VARPTR"  // Ext one is wrong
	///table[0xEE] = "INKEY$"  // Ext one is wrong
	table[0xEF] = ">"   // 8K
	table[0xF0] = "="   // 8K
	table[0xF1] = "<"   // 8K
	table[0xF2] = "+"   // 8K
	table[0xF3] = "-"   // 8K
	table[0xF4] = "*"   // 8K
	table[0xF5] = "/"   // 8K
	table[0xF6] = "^"   // 8K
	table[0xF7] = "AND" // 8K
	table[0xF8] = "OR"  // 8K
	table[0xF9] = "XOR" // 8K
	table[0xFA] = "EQV" // 8K
	table[0xFB] = "IMP" // 8K
	table[0xFC] = "\\"  // 8K
	table[0xFD] = "MOD" // 8K

	table2 := map[int]string{}

	// need INPUT$(X[,#F]) // Disk

	table2[0x81] = "LEFT$"  // 8K
	table2[0x82] = "RIGHT$" // 8K
	table2[0x83] = "MID$"   // 8K
	table2[0x84] = "SGN"    // 8K
	table2[0x85] = "INT"    // 8K
	table2[0x86] = "ABS"    // 8K
	table2[0x87] = "SQR"    // 8K
	table2[0x88] = "RND"    // 8K
	table2[0x89] = "SIN"    // 8K
	table2[0x8A] = "LOG"    // 8K
	table2[0x8B] = "EXP"    // 8K
	table2[0x8C] = "COS"    // 8K
	table2[0x8D] = "TAN"    // 8K
	table2[0x8E] = "ATN"    // 8K
	table2[0x8F] = "FRE"    // 8K
	table2[0x90] = "INP"    // 8K
	table2[0x91] = "POS"    // 8K
	table2[0x92] = "LEN"    // 8K
	table2[0x93] = "STR$"   // 8K
	table2[0x94] = "VAL"    // 8K
	table2[0x95] = "ASC"    // 8K
	table2[0x96] = "CHR$"   // 8K
	table2[0x97] = "PEEK"   // 8K
	table2[0x98] = "SPACE$" // Ext
	table2[0x99] = "OCT$"   // Ext
	table2[0x9A] = "HEX$"   // Ext
	table2[0x9B] = "LPOS"   // Ext
	table2[0x9C] = "CINT"   // Ext
	table2[0x9D] = "CSNG"   // Ext
	table2[0x9E] = "CDBL"   // Ext
	table2[0x9F] = "FIX"    // Ext
	// table2[0xAA] = ""
	table2[0xAB] = "CVI" // Disk
	table2[0xAC] = "CVS" // Disk
	table2[0xAD] = "CVD" // Disk
	table2[0xAE] = "EOF" // Disk
	// table2[0xAF] = ""
	table2[0xB0] = "LOC"  // Disk
	table2[0xB1] = "LOF"  // is this a function?
	table2[0xB2] = "MKI$" // Disk
	table2[0xB3] = "MKS$" // Disk
	table2[0xB4] = "MKD$" // Disk

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
