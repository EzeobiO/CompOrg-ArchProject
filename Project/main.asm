INCLUDE Irvine32.inc
.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword
DumpRegs PROTO

.data
	teamName db   "--------Team EMO Project--------", 0
	theprocess db "-----Selection Sort Process------", 0
	initialTable db "-----Original Student Table-----", 0
	endResult db "-------Result/Sorted Table-------", 0
	distribution db "-------Grade Distribution-------", 0
	gradeLetters db "A's:,B's:,C's:,D's:,F's:,", 0
	gradeArray db 0, 0, 0 , 0, 0
	nameswap1 dword 0
	nameswap2 dword 0
	tempstorage dword 0
	myData db 90, 86, 74, 79, 95, 93, 64, 53, 80, 61
    names db ",Sarah,James,Tom,Jane,Sally,John,Jack,Julie,Yasmin,Frank,",0
	swappedNames db ",Sarah,James,Tom,Jane,Sally,John,Jack,Julie,Yasmin,Frank,",0
	studentName db 0, 0
	mylength equ 10
	num1 dword 0
	num2 dword 0
	num3 dword 0
	num4 dword 0

.code
main PROC
;Initializing registers
	xor eax, eax
	xor ebx, ebx
	xor ecx, ecx
	xor edx, edx
	xor esi, esi
	xor edi, edi

print_TeamName:								;Printing out team name
	mov edx, offset teamName				;Load data teamName into the edx register
	call writestring						;Print
	call crlf								;Go to next line
	call crlf								;Go to next line

print_initialTable:							;Printing out "Original Table"
	mov edx, offset initialTable			;Load data initialTable into the edx register
	call writestring						;Print
	call crlf								;Go to next line

;Printing out Unsorted Table
print_originalTable:						
	cmp ebx, 10								;Compare value in ebx register to value 10
	je selection_sort						;If equal, jump to selection_sort
	mov al, [names + esi]					;Load an element from the names array into al
	mov [studentName], al					;Store al into data studentName
	cmp studentName, ','					;Compare value in data studentName and ','(used as an index for names Array)
	je check_for_index_original				;If equal, jump to check_for_index_original	
	mov edx, offset studentName				;Load offset of data studentName (studentName is of type Byte) into the edx register
	call writestring						;Print
	inc esi									;Increment value in esi register by 1
	inc ecx									;Increment value in ecx register by 1
	jmp print_originalTable					;Jump to print_originalTable unconditionally

check_for_index_original:                   
	cmp ecx, 0                              ;Compare value in ebx register to 0
	jne print_original_grade                ;If not equal, jump to print_original_grade
	inc ecx                                 ;Increment value in ecx register by 1
	inc esi                                 ;Increment value in esi register by 1
	jmp print_originalTable                 ;Jump to print_originalTable unconditionally

print_original_grade:
	mov [studentName], ' '                  ;Store ' ' into data studentName
	mov edx, offset studentName             ;Load offset of data studentName (studentName is of type Byte) into the edx register
	call writestring                        ;Print
	inc esi                                 ;Increment value in esi register by 1
	inc ecx                                 ;Increment value in ecx register by 1
	xor eax, eax                            ;Perform exclusive or with eax register 
	mov al, [myData + ebx]                  ;Load an element from the myData array into al
	call writedec                           ;Print
	call crlf                               ;Go to next line
	inc ebx                                 ;Increment value in ebx register by 1
	jmp print_originalTable                 ;Jump to print_originalTable unconditionally

selection_sort:
	xor eax, eax                            ;Perform exclusive or with eax register which zeros out
	xor ebx, ebx                            ;Perform exclusive or with ebx register which zeros out
	xor ecx, ecx                            ;Perform exclusive or with ecx register which zeros out
	xor edx, edx                            ;Perform exclusive or with edx register which zeros out
	xor esi, esi                            ;Perform exclusive or with esi register which zeros out
	xor edi, edi                            ;Perform exclusive or with edi register which zeros out
	call crlf                               ;Go to next line
	mov edx, offset theprocess              ;Load offset of data theprocess (theprocess is of type Byte) into the edx register
	call writestring                        ;Print
	call crlf                               ;Go to next line

	;Selection Sort
outer_loop:
	cmp ecx, mylength                       ;Compare value in ecx and mylength (equal to 10)
	je print_Result                         ;If equal, jump to print_Result
	mov esi, ecx                            ;Move content from ecx register to esi register
	mov ebx, esi                            ;Move content from esi register to ebx register
	inc ebx                                 ;Increment value in ebx register by 1

inner_loop:
	cmp ebx, mylength                       ;Compare value in ebx and mylength
	je swap_grades                          ;If equal, jump to swap_grades
	mov al, [myData + ebx]                  ;Load an element from the myData array into ebx
	mov dl, [myData + esi]                  ;Load an element from the myData array into esi
	cmp al, dl                              ;Compare value in al to value in dl
	jge increment_inner_loop                ;If greater than or equal, jump to increment_inner_loop
	mov esi, ebx                            ;Load data from ebx register into the esi register

increment_inner_loop:
	inc ebx                                 ;Increment value in ebx register by 1
	jmp inner_loop                          ;Jump to inner_loop unconditionally

swap_grades:
	cmp ecx, esi                            ;Compare value in ecx with value in esi
	je increment_outer_loop_no_sort         ;If equal, jump to increment_outer_loop_no_sort
	mov al, [myData + esi]                  ;Move memory from [myData + esi] (calculated memory address) into al
	mov dl, [myData + ecx]                  ;Move memory from [myData + ecx] (calculated memory address) into dl
	mov [myData + ecx], al                  ;Move data from al into [myData + ecx] (calculated memory address)
	mov [myData + esi], dl                  ;Move data from dl into [myData + esi] (calculated memory address)
	mov [nameswap1], ecx                    ;Move data from ecx to [nameswap1] (memory location)
	mov [nameswap2], esi                    ;Move data from esi to [nameswap2] (memory location)
	mov tempstorage, ecx                    ;Move data from ecx to tempstorage
	xor eax, eax                            ;Zero out eax
	xor edx, edx                            ;Zero out edx
	xor ebx, ebx                            ;Zero out ebx
	xor ecx, ecx                            ;Zero out ecx
	xor esi, esi                            ;Zero out esi

start_swap:
	cmp ebx, 10                             ;Compare value in ebx register to value 10
	je complete_transfer                    ;If equal, jump to complete_transfer
	cmp ebx, nameswap1                      ;Compare value in ebx register to value in nameswap1
	je first_instance                       ;If equal, jump to first_instance
	cmp ebx, nameswap2                      ;Compare value in ebx register to value in nameswap2
	je prepare_final                        ;If equal, jump to prepare_final 
	mov al, [names + ecx]                   ;Move memory from [names + ecx] (calculated memory address) into al
	mov [swappedNames + esi], al            ;Move data from al into [swappedNames + esi] (calculated memory address)
	mov [studentName], al                   ;Move data from al to [StudentName] (memory location)
	inc ecx                                 ;Increment value in ecx register by 1
	inc esi                                 ;Increment value in esi register by 1
	cmp studentName, ','                    ;Compare value in data studentName and ','(used as an index for names Array)
	je next_index                           ;If equal, jump to next_index
	jmp start_swap                          ;Jump to start_swap unconditionally

next_index:
	cmp ecx, 1                              ;Compare value in register ecx to value 1
	jle start_swap                          ;If less than or equal, jump to start_swap
	inc ebx                                 ;Increment value in ebx register by 1
	jmp start_swap                          ;Jump to start_swap unconditionally

first_instance:
	mov [num1], ecx                         ;Move value in ecx into [num1] (memory location)
	mov [num2], ebx                         ;Move value in ebx into [num2] (memory location)
	jmp first_swap                          ;Jump to first_swap unconditionally

minor_interlude:
	cmp num1, 0                             ;Compare value in num1 to value 0
	jne finish_first_swap                   ;If not equal, jump to finish_first_swap      
	dec ecx                                 ;Decrement value in ecx register by 1
	jmp finish_first_swap                   ;Jump to finish_first_swap unconditionally

first_swap:
	cmp ebx, nameswap2                      ;Compare value in ebx register to value in nameswap2
	je minor_interlude                      ;If equal, jump to minor_interlude
	mov al, [names + ecx]                   ;Move memory from [names + ecx] (calculated memory address) into al
	mov [studentName], al                   ;Move data from al to [StudentName] (memory location)
	inc ecx                                 ;Increment value in ecx register by 1
	cmp studentName, ','                    ;Compare value in data studentName and ','(used as an index for names Array)
	jne first_swap                          ;If not equal, jump to first_swap
	inc ebx                                 ;Increment value in ebx register by 1
	jmp first_swap                          ;Jump to first_swap unconditionally

finish_first_swap:
	mov al, [names + ecx]                   ;Move memory from [names + ecx] (calculated memory address) into al
	mov [swappedNames + esi], al            ;Move data from al into [swappedNames + esi] (calculated memory address)
	mov [studentName], al                   ;Move data from al to [StudentName] (memory location)
	inc ecx                                 ;Increment value in ecx register by 1
	inc esi                                 ;Increment value in esi register by 1
	cmp studentName, ','                    ;Compare value in data studentName and ','(used as an index for names Array)
	je second_instance                      ;If equal, jump to second_instance
	jmp finish_first_swap                   ;Jump to finish_first_swap unconditionally

second_instance:
	mov [num3], ecx
	mov edi, ebx
	mov ecx, [num1]
	mov ebx, [num2]
	jmp iterate

iterate:
	mov al, [names + ecx]                    ;Move memory from [names + ecx] (calculated memory address) into al
	mov [studentName], al
	inc ecx
	cmp studentName, ','                     ;Compare value in data studentName and ','(used as an index for names Array)
	je next_index
	jmp iterate

prepare_final:
	mov ecx, [num1]
	mov ebx, [num2]
	jmp second_swap

second_swap:
	mov al, [names + ecx]                     ;Move memory from [names + ecx] (calculated memory address) into al
	mov [swappedNames + esi], al
	mov [studentName], al
	inc ecx
	inc esi
	cmp studentName, ','
	je final
	jmp second_swap

final:
	mov ecx, [num3]
	mov ebx, edi
	jmp next_index

complete_transfer:
	xor ecx, ecx
	xor ebx, ebx

little_loop:
	cmp ebx, mylength
	jg prepare_printer
	mov al, [swappedNames + ecx]
	mov [names + ecx], al
	mov [studentName], al
	inc ecx
	cmp studentName, ','
	jne little_loop
	inc ebx
	jmp little_loop

increment_outer_loop:
	call crlf
	mov ecx, tempstorage
	xor ebx, ebx
	xor esi, esi
	inc ecx
	jmp outer_loop

increment_outer_loop_no_sort:
	call crlf
	xor ebx, ebx
	xor esi, esi
	inc ecx
	jmp outer_loop

	;Student Table Printout
prepare_printer:
	xor edx, edx
	xor ecx, ecx
	xor eax, eax
	xor ebx, ebx
	xor esi, esi
	jmp print_studentTable

print_studentTable:
	cmp ebx, 10
	je increment_outer_loop
	mov al, [names + esi]
	mov [studentName], al
	cmp studentName, ','
	je check_for_index
	mov edx, offset studentName
	call writestring
	inc esi
	inc ecx
	jmp print_studentTable

check_for_index:
	cmp ecx, 0
	jne print_grade
	inc ecx
	inc esi
	jmp print_studentTable

print_grade:
	mov [studentName], ' '
	mov edx, offset studentName
	call writestring
	inc esi
	inc ecx
	xor eax, eax
	mov al, [myData + ebx]
	call writedec
	call crlf
	inc ebx
	jmp print_studentTable

print_Result:
xor eax, eax
	xor ebx, ebx
	xor ecx, ecx
	xor edx, edx
	xor esi, esi
	xor edi, edi
	mov edx, offset endResult
	call writestring
	call crlf

print_finalTable:
	cmp ebx, 10
	je print_distribution
	mov al, [names + esi]
	mov [studentName], al
	cmp studentName, ','
	je check_for_index_final
	mov edx, offset studentName
	call writestring
	inc esi
	inc ecx
	jmp print_finalTable

check_for_index_final:
	cmp ecx, 0
	jne print_final_grade
	inc ecx
	inc esi
	jmp print_finalTable

print_final_grade:
	mov [studentName], ' '
	mov edx, offset studentName
	call writestring
	inc esi
	inc ecx
	xor eax, eax
	mov al, [myData + ebx]
	call writedec
	call crlf
	inc ebx
	jmp print_finalTable

print_distribution:
	call crlf
	xor eax, eax
	xor ebx, ebx
	xor ecx, ecx
	xor edx, edx
	xor esi, esi
	xor edi, edi
	mov edx, offset distribution
	call writestring
	call crlf

count_grades:
	cmp ecx, 10
	je print_letter_gradeArray
	cmp [myData + ecx], 90
	jge next_grade_A
	cmp [myData + ecx], 80
	jge next_grade_B
	cmp [myData + ecx], 70
	jge next_grade_C
	cmp [myData + ecx], 60
	jge next_grade_D
	cmp [myData + ecx], 60
	jl next_grade_F

next_grade_A:
	add gradeArray[0], 1
	inc ecx
	jmp count_grades

next_grade_B:
	add gradeArray[1], 1
	mov al, gradeArray[1]
	inc ecx
	jmp count_grades

next_grade_C:
	add gradeArray[2], 1
	inc ecx
	jmp count_grades

next_grade_D:
	add gradeArray[3], 1
	inc ecx
	jmp count_grades

next_grade_F:
	add gradeArray[4], 1
	inc ecx
	jmp count_grades

print_letter_gradeArray:
	cmp ebx, 5
	je ending_all
	mov al, [gradeLetters + esi]
	mov [studentName], al
	cmp studentName, ','
	je print_integer_gradeArray
	mov edx, offset studentName
	call writestring
	inc esi
	inc ecx
	jmp print_letter_gradeArray

print_integer_gradeArray:
	mov [studentName], ' '
	mov edx, offset studentName
	call writestring
	inc esi
	inc ecx
	xor eax, eax
	mov al, [gradeArray + ebx]
	call writedec
	call crlf
	inc ebx
	jmp print_letter_gradeArray

ending_all:
	xor ecx, ecx
	call crlf

final_form:
	cmp ecx, 5
	je ending
	xor eax, eax
	mov al, [gradeArray + ecx]
	call writedec
	inc ecx
	jmp final_form

ending:
	call crlf

    INVOKE ExitProcess, 0
main ENDP
END main